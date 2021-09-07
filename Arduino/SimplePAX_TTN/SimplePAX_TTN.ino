// https://fhnw.mit-license.org/

// based on https://github.com/nkolban/ESP32_BLE_Arduino/blob/master/examples/

// Based on https://github.com/mcci-catena/arduino-lmic/tree/master/examples
// Copyright (c) 2015 Thomas Telkamp and Matthijs Kooijman
// Copyright (c) 2018 Terry Moore, MCCI
// Licensed under MIT License

#define DISABLE_PING // https://github.com/mcci-catena/arduino-lmic#disabling-ping
#define DISABLE_BEACONS // https://github.com/mcci-catena/arduino-lmic#disabling-beacons


#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>
#include <CRC32.h>

#include <lmic.h>
#include <hal/hal.h>
#include <SPI.h>


#define MAC_BUFFER_SIZE 50 // maximum number of unique randomized devices

// timing parameters
int bleScanTime = 3; // in seconds
int scanInterval = 30; // perform a scan every <scanInterval> seconds
int intervalsUntilTransmit = 30; // transmit the data after <intervalsUntilTransmit> scans


#define BATTERY_PIN A13

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

static uint8_t payload[4];
static osjob_t sendjob;

BLEScan* pBLEScan;

// Stored in SRAM, still there after deep sleep
RTC_DATA_ATTR uint32_t randomizedDeviceCrcs[MAC_BUFFER_SIZE];
RTC_DATA_ATTR uint8_t nrOfRandomizedDevices = 0;
RTC_DATA_ATTR uint8_t scanCounter = 0;
RTC_DATA_ATTR lmic_t RTC_LMIC;

// used for additional info
int publicdevs = 0;
int randomizeddevs = 0;
int starttime = 0;
#define LMIC_PRINTF_TO Serial
#define LMIC_DEBUG_LEVEL 2

float getBatteryLevel() {
	return (analogRead(BATTERY_PIN) / 4095.0) * 2 * 1.1 * 3.3;
}

void goToSleep() {
	uint32_t sleepduration = (scanInterval * 1000) < millis() ? 0 : (scanInterval * 1000 - millis()) * 1000;
	Serial.printf("Battery Level is %f, going to sleep for %d us", getBatteryLevel(), sleepduration);
	ESP.deepSleep(sleepduration);
}

void SaveLMIC() {
	RTC_LMIC = LMIC;
}

void LoadLMIC() {
	LMIC = RTC_LMIC;
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
	/*
	payload[2] = highByte(batteryVoltage);
	payload[3] = lowByte(batteryVoltage);
	*/
}

uint32_t getCrc32(const char* payload) {
	return  CRC32::calculate(payload, sizeof(payload) - 1);
}

void clearCRCs() {
	for (int i = 0; i < nrOfRandomizedDevices; ++i) {
		randomizedDeviceCrcs[i] = 0;
	}
	nrOfRandomizedDevices = 0;
}

boolean addCRC(uint32_t crc) {
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
	addCRC(getCrc32(deviceaddress));
}

/*
void printDeviceDetails(BLEAdvertisedDevice dev) {
	const char* address = dev.getAddress().toString().c_str();
	//Serial.print(" Address\t");
	Serial.print(dev.getAddress().toString().c_str());
	Serial.print(" RSSI: ");
	Serial.print(dev.getRSSI());
	Serial.print("\t");

	switch (dev.getAddressType())
	{
	case 0x00: {
		Serial.print("PUBLIC");
		publicdevs++;
		break;
	}
	case 0x01: {
		Serial.print("RANDOM");
		randomizeddevs++;
		const char* address = dev.getAddress().toString().c_str();
		addCRC(getCrc32(address));
		break;
	}
	case 0x02: {
		Serial.print("RPA_PUBLIC");
		break;
	}
	case 0x03: {
		Serial.print("RPA_RANDOM");
		break;
	}
	default:
		break;
	}

	Serial.print(" ");
	Serial.print(dev.getName().c_str());
	Serial.println(millis() - starttime);
}

*/

class MyAdvertisedDeviceCallbacks : public BLEAdvertisedDeviceCallbacks {
	void onResult(BLEAdvertisedDevice advertisedDevice) {
		//Serial.printf("Advertised Device: %s ", advertisedDevice.toString().c_str());
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
	pBLEScan->setInterval(150);
	pBLEScan->setWindow(150);  // less or equal setInterval value
}

void do_send(osjob_t* j) {
	Serial.println("doSend()");
	if ((LMIC.opmode & OP_TXRXPEND) == 0) { // No TX/RX pending
		//updatePayload();
		LMIC_setTxData2(1, payload, sizeof(payload), 0); // queue TX packet
	}
	// Next, EV_TXCOMPLETE
}

void onEvent(ev_t ev) {
	Serial.println("onEvent()");

	if (ev == EV_TXCOMPLETE) {
		Serial.println("EV_TXCOMPLETE");
		clearCRCs();
		goToSleep();
	}
	else if (ev == EV_JOINING) {
		Serial.println("EV_JOINING");
	}
	else if (ev == EV_JOINED) {
		Serial.println("EV_JOINED");
	}
	else {
		Serial.println((unsigned)ev);
	}
}

void setupLora() {
	Serial.println("Setting up Lora");
	Serial.println("os_init();");
	os_init();
	Serial.println("LMIC_reset();");
	LMIC_reset();
	if (LMIC.seqnoUp != 0)
	{
		Serial.println("loading LMIC from RTC");
		LoadLMIC();
	}
	else {
		Serial.println("Init LORA");
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
		LMIC_setDrTxpow(DR_SF7, 14);
	}
}



void setup() {
	Serial.begin(115200);
	setupBleScanner();

	Serial.print("Scan #");
	Serial.println(scanCounter);

	BLEScanResults foundDevices = pBLEScan->start(bleScanTime, false);
	//  Serial.print("Devices found: ");
	//  Serial.print(foundDevices.getCount());
	pBLEScan->clearResults();   // delete results fromBLEScan buffer to release memory

	Serial.printf("Found %d randomized devices\n", nrOfRandomizedDevices);
	scanCounter++;

	updatePayload();
	Serial.printf("Payload: [%d   %d]", payload[0], payload[1]);

	if (scanCounter >= intervalsUntilTransmit) {
		Serial.printf("Time to transmit. Total %d randomized devices\n", nrOfRandomizedDevices);
		setupLora();
		updatePayload();
		// transmit to ttn
		do_send(&sendjob);
		// EV_TXCOMPLETE clears CRC's and starts sleeping
	}
	else {
		goToSleep();
	}
}

void loop() {
	//os_runloop_once();
}
