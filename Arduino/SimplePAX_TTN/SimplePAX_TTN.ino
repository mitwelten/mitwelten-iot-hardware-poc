// https://fhnw.mit-license.org/

// based on https://github.com/nkolban/ESP32_BLE_Arduino/blob/master/examples/

// Based on https://github.com/mcci-catena/arduino-lmic/tree/master/examples
// Copyright (c) 2015 Thomas Telkamp and Matthijs Kooijman
// Copyright (c) 2018 Terry Moore, MCCI
// Licensed under MIT License

#define DISABLE_PING // https://github.com/mcci-catena/arduino-lmic#disabling-ping
#define DISABLE_BEACONS // https://github.com/mcci-catena/arduino-lmic#disabling-beacons

#define LMIC_DEBUG_LEVEL 0 // increase to get LMIC output
#define LMIC_PRINTF_TO Serial

#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>
#include <CRC32.h>
#include <lmic.h>
#include <hal/hal.h>
#include <SPI.h>

#define TX_INTERVAL 10*60 // interval to transmit to ttn in seconds
#define LORA_TX_DATARATE DR_SF8 // SF to transmit

#define MAC_BUFFER_SIZE 150 // maximum number of unique randomized devices
#define BLE_SCANDURATION 3 // duration of a single scan, in seconds
#define BLE_SCAN_INTERVAL 150 // ble scan interval in ms
#define BLE_SCAN_WINDOW 150 // ble scan window in ms (must be less or equal to BLE_SCAN_INTERVAL)

int scanInterval = 30; // perform a scan every <scanInterval> seconds


#define BATTERY_PIN A13 
#define ONBOARD_LED_PIN 13

const lmic_pinmap lmic_pins = {
  .nss = 14, // E = CS
  .rxtx = LMIC_UNUSED_PIN,
  .rst = 32, // D = RST
  .dio = {
	33, // B = DIO0 = IRQ 
	15, // C = DIO1
	LMIC_UNUSED_PIN
  },
};

static uint8_t NWKSKEY[16] = // TODO, msb
{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

static uint8_t APPSKEY[16] = // TODO, msb
{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

static const u4_t DEVADDR = 0x00000000; // TODO, msb

void os_getArtEui(u1_t* buf) { }
void os_getDevEui(u1_t* buf) { }
void os_getDevKey(u1_t* buf) { }

static uint8_t payload[2];
static osjob_t sendjob;

BLEScan* pBLEScan;

// Stored in SRAM, still there after deep sleep (if used)
RTC_DATA_ATTR uint32_t randomizedDeviceCrcs[MAC_BUFFER_SIZE];
RTC_DATA_ATTR uint8_t nrOfRandomizedDevices = 0;
RTC_DATA_ATTR uint8_t scanCounter = 0;

uint32_t scanStartTime;
uint32_t lastTransmitMillis = 0;


float getBatteryLevel() {
	return (analogRead(BATTERY_PIN) / 4095.0) * 2 * 1.1 * 3.3;
}


void goToSleep(uint32_t sleepDurationMs) {
	if (sleepDurationMs > 100) {
		esp_sleep_enable_timer_wakeup((sleepDurationMs - 100) * 1000);
		delay(100);
		esp_err_t sleepok= esp_light_sleep_start();
	}
	else {
		delay(sleepDurationMs);
	}
}


void updatePayload() {
	int batteryVoltage = 50.0 * getBatteryLevel();
	payload[0] = nrOfRandomizedDevices;
	if (batteryVoltage < 255) {
		payload[1] = (uint8_t)batteryVoltage;
	}
	else {
		payload[1] = 0;
	}
}


uint32_t calculateCRC32(const char* payload) {
	return  CRC32::calculate(payload, sizeof(payload) - 1);
}


void clearCRCs() {
	for (int i = 0; i < nrOfRandomizedDevices; ++i) {
		randomizedDeviceCrcs[i] = 0;
	}
	nrOfRandomizedDevices = 0;
	scanCounter = 0;
}


boolean addCRCIfNew(uint32_t crc) {
	if (nrOfRandomizedDevices == MAC_BUFFER_SIZE) {
		return false;
	}
	for (int i = 0; i < nrOfRandomizedDevices; ++i) {
		if (randomizedDeviceCrcs[i] == crc) {
			return false;
		}
	}
	randomizedDeviceCrcs[nrOfRandomizedDevices] = crc;
	nrOfRandomizedDevices++;
	return true;
}


void countDevice(const char* deviceaddress) {
	addCRCIfNew(calculateCRC32(deviceaddress));
}


class MyAdvertisedDeviceCallbacks : public BLEAdvertisedDeviceCallbacks {
	void onResult(BLEAdvertisedDevice advertisedDevice) {
		////Serial.printf("Advertised Device: %s ", advertisedDevice.toString().c_str());
		if (advertisedDevice.getAddressType() == 0x01) {
			countDevice(advertisedDevice.getAddress().toString().c_str());
		}
	}
};


void setupBleScanner() {
	BLEDevice::init("");
	pBLEScan = BLEDevice::getScan(); //create new scan
	pBLEScan->setAdvertisedDeviceCallbacks(new MyAdvertisedDeviceCallbacks());
	pBLEScan->setActiveScan(false); //active scan uses more power, but get results faster
	pBLEScan->setInterval(BLE_SCAN_INTERVAL);
	pBLEScan->setWindow(BLE_SCAN_WINDOW);  // less or equal setInterval value
}


void scanPAX() {
	//Serial.printf("bt_status calling scanPAX=%d\n", esp_bt_controller_get_status());
	//uint32_t m1 = millis();
	//setupBleScanner();
	//Serial.printf("time to setup: %d\n", millis() - m1);
	//Serial.print("Scan #");
	//Serial.print(scanCounter);

	BLEScanResults foundDevices = pBLEScan->start(BLE_SCANDURATION, false);
	//  //Serial.print("Devices found: ");
	//  //Serial.print(foundDevices.getCount());
	pBLEScan->clearResults();   // delete results fromBLEScan buffer to release memory
	//Serial.printf(" --> %d randomized devices\n", nrOfRandomizedDevices);
	scanCounter++;
	//esp_bt_controller_disable(); // is this done by esp light sleep?
	////Serial.printf("bt_status before deinit=%d\n", esp_bt_controller_get_status());
	//uint32_t m2 = millis();
	//BLEDevice::deinit();
	//Serial.printf("bt_status end of scanPAX=%d\n", esp_bt_controller_get_status());
	//Serial.printf("time to deinit: %d, duration deinit = %d\n", millis() - m1, millis()-m2);

}


void periodicScanUntil(uint32_t timeToStop) {
	while (timeToStop > millis() + (BLE_SCANDURATION + 2) * 1000) {
		scanStartTime = millis();
		scanPAX();
		uint32_t timeConsumed = millis() - scanStartTime;
		if (timeConsumed < scanInterval * 1000) {
			goToSleep(scanInterval * 1000 - timeConsumed);
		}
	}
	uint32_t time_left = timeToStop > millis() ? timeToStop - millis() : 0;
	goToSleep(time_left);
}


void do_send(osjob_t* j) {
	//Serial.println("doSend()");
	if ((LMIC.opmode & OP_TXRXPEND) == 0) { // No TX/RX pending
		lastTransmitMillis = millis();
		//Serial.println("ready to send");
		updatePayload();
		//Serial.printf("Sending Payload: [%d   %d]", payload[0], payload[1]);
		LMIC_setTxData2(1, payload, sizeof(payload), 0); // queue TX packet
		digitalWrite(ONBOARD_LED_PIN, HIGH);
	}
	// Next, EV_TXCOMPLETE
}


void onEvent(ev_t ev) {
	//Serial.println("onEvent()");
	if (ev == EV_TXCOMPLETE) {
		//Serial.println("EV_TXCOMPLETE");
		digitalWrite(ONBOARD_LED_PIN, LOW);
		clearCRCs();
		//scanNtimes(intervalsUntilTransmit);
		periodicScanUntil(lastTransmitMillis + TX_INTERVAL * 1000 - 100);
		os_setTimedCallback(&sendjob, os_getTime() +
			ms2osticksRound(100), do_send);
	}
	else if (ev == EV_JOINING) {
		//Serial.println("EV_JOINING");
	}
	else if (ev == EV_JOINED) {
		//Serial.println("EV_JOINED");
	}
	else {
		//Serial.println((unsigned)ev);
	}
}


void setupLora() {
	//Serial.println("Setting up Lora");
	delay(100);
	//Serial.println("os_init();");
	os_init();
	//Serial.println("LMIC_reset();");
	LMIC_reset();
	LMIC_setSession(0x13, DEVADDR, NWKSKEY, APPSKEY);

#if defined(CFG_eu868)
	LMIC_setupChannel(0, 868100000, DR_RANGE_MAP(DR_SF12, DR_SF7), BAND_CENTI);
	LMIC_setupChannel(1, 868300000, DR_RANGE_MAP(DR_SF12, DR_SF7B), BAND_CENTI);
	LMIC_setupChannel(2, 868500000, DR_RANGE_MAP(DR_SF12, DR_SF7), BAND_CENTI);
	LMIC_setupChannel(3, 867100000, DR_RANGE_MAP(DR_SF12, DR_SF7), BAND_CENTI);
	LMIC_setupChannel(4, 867300000, DR_RANGE_MAP(DR_SF12, DR_SF7), BAND_CENTI);
	LMIC_setupChannel(5, 867500000, DR_RANGE_MAP(DR_SF12, DR_SF7), BAND_CENTI);
	LMIC_setupChannel(6, 867700000, DR_RANGE_MAP(DR_SF12, DR_SF7), BAND_CENTI);
	LMIC_setupChannel(7, 867900000, DR_RANGE_MAP(DR_SF12, DR_SF7), BAND_CENTI);
	LMIC_setupChannel(8, 868800000, DR_RANGE_MAP(DR_FSK, DR_FSK), BAND_MILLI);
#else
#error Region not supported
#endif
	LMIC_setLinkCheckMode(0);
	LMIC.dn2Dr = DR_SF9; // TTN RX2 window
	LMIC_setDrTxpow(LORA_TX_DATARATE, 14);
}


void setup() {
	//Serial.begin(115200);
	pinMode(ONBOARD_LED_PIN, OUTPUT);
	digitalWrite(ONBOARD_LED_PIN, HIGH);
	setupLora();
	delay(100);
	setupBleScanner();
	scanPAX(); // do one scan
	do_send(&sendjob); // transmit data
}


void loop() {
	os_runloop_once();
}
