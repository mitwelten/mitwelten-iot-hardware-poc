// https://fhnw.mit-license.org/

// based on https://github.com/nkolban/ESP32_BLE_Arduino/blob/master/examples/

#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>
#include <CRC32.h>

#define BATTERY_PIN A13

int bleScanTime = 3; // in seconds
int scanInterval = 30; // perform a scan every <scanInterval> seconds
int intervalsUntilTransmit = 10; // transmit the data after <intervalsUntilTransmit> scans

BLEScan* pBLEScan;


// Stored in SRAM, still there after deep sleep
RTC_DATA_ATTR uint32_t randomizedDeviceCrcs[50];
RTC_DATA_ATTR uint8_t nrOfRandomizedDevices = 0;
RTC_DATA_ATTR uint8_t scanCounter = 0;


// used for additional info
int publicdevs = 0;
int randomizeddevs = 0;
int starttime = 0;

float getBatteryLevel() {
	return (analogRead(BATTERY_PIN) / 4095.0) * 2 * 1.1 * 3.3;
}

uint32_t getCrc32(const char* payload) {
	return  CRC32::calculate(payload, sizeof(payload) - 1);
}

void countDevice(const char* deviceaddress) {
	addCRC(getCrc32(deviceaddress));
}

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

void clearCRCs() {
	for (int i = 0; i < nrOfRandomizedDevices; ++i) {
		randomizedDeviceCrcs[i] = 0;
	}
	nrOfRandomizedDevices = 0;
}

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

	if (scanCounter >= intervalsUntilTransmit) {
		Serial.printf("Time to transmit. Total %d randomized devices\n", nrOfRandomizedDevices);
		// put value in payload
		// transmit to ttn
		clearCRCs();
	}

	uint32_t sleepduration = (scanInterval * 1000) < millis() ? 0 : (scanInterval * 1000 - millis()) * 1000;
	Serial.printf("Battery Level is %f, going to sleep for %d us",getBatteryLevel(), sleepduration);
	ESP.deepSleep(sleepduration);
}

void loop() {

}
