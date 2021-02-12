// https://tamberg.mit-license.org/

// Based on https://github.com/mcci-catena/arduino-lmic/tree/master/examples
// Copyright (c) 2015 Thomas Telkamp and Matthijs Kooijman
// Copyright (c) 2018 Terry Moore, MCCI
// Licensed under MIT License

// Based on https://github.com/adafruit/Adafruit_SleepyDog/tree/master/examples
// Copyright (c) 2015 Adafruit Industries
// Licensed under MIT License

#define DISABLE_PING // https://github.com/mcci-catena/arduino-lmic#disabling-ping
#define DISABLE_BEACONS // https://github.com/mcci-catena/arduino-lmic#disabling-beacons

// TODO: Include MCCI LoRaWAN LMIC library, https://github.com/mcci-catena/arduino-lmic
// TODO: Enable CFG_eu868 in ARDUINO_HOME/libraries/arduino-lmic/project_config/lmic_project_config.h

#include <lmic.h>
#include <hal/hal.h>
#include <SPI.h>
#include <Adafruit_SleepyDog.h>

#define VBATPIN A6
#define MOISPIN A4 // Grove A4, https://www.seeedstudio.com/Grove-Capacitive-Moisture-Sensor-Corrosion-Resistant.html

// TODO: Register the device in https://console.thethingsnetwork.org/ use ABP, disable frame counter.
// TODO: Check data in https://console.thethingsnetwork.org/applications/APP_ID/devices/DEVICE_ID

static uint8_t NWKSKEY[16] = // TODO, msb
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

static uint8_t APPSKEY[16] = // TODO, msb
  { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

static const u4_t DEVADDR = 0x00000000; // TODO, msb

const unsigned int TX_INTERVAL_MS = 15 * 60 * 1000; // > 15 min for long term use

static uint8_t payload[4];
static osjob_t sendjob;

// Pin mapping, see https://github.com/tamberg/fhnw-iot/wiki/FeatherWing-RFM95W
// Feather M4 Express with FeatherWing RFM95W
const lmic_pinmap lmic_pins = {
  .nss = 5, // E = CS
  .rxtx = LMIC_UNUSED_PIN,
  .rst = 6, // D = RST
  .dio = {
    10, // B = DIO0 = IRQ 
    9, // C = DIO1
    LMIC_UNUSED_PIN
  },
};

void os_getArtEui (u1_t* buf) {} // ignore
void os_getDevEui (u1_t* buf) {} // ignore
void os_getDevKey (u1_t* buf) {} // ignore

void lowPowerDelay(int ms) {
  int dms;
  do {
    dms = Watchdog.sleep(ms);
    ms -= dms;
  } while (ms > 0);
}

void updateMeasurement() {
  //Serial.println("updateMeasurement()");
  // read sensor values first
  digitalWrite(LED_BUILTIN, HIGH);
  int m = analogRead(MOISPIN);
  //Serial.print("m = ");
  //Serial.println(m);
  delay(10);
  digitalWrite(LED_BUILTIN, LOW);

  // read battery voltage last
  float b = analogRead(VBATPIN);
  b *= 2; // und-divide by 2
  b *= 3.3; // ref voltage
  b /= 1024; // resolution
  int b2 = 100.0 * b; // send float as int

  // update payload
  payload[0] = highByte(b2);
  payload[1] = lowByte(b2);
  payload[2] = highByte(m);
  payload[3] = lowByte(m);
}

void do_send(osjob_t* j) {
  //Serial.println("doSend()");
  if ((LMIC.opmode & OP_TXRXPEND) == 0) { // No TX/RX pending
    updateMeasurement();
    LMIC_setTxData2(1, payload, sizeof(payload), 0); // queue TX packet
  }
  // Next, EV_TXCOMPLETE
}

void onEvent (ev_t ev) {
  //Serial.println("onEvent()");
  if (ev == EV_TXCOMPLETE) {
    //Serial.println("EV_TXCOMPLETE");
    lowPowerDelay(TX_INTERVAL_MS - 100);
    os_setTimedCallback(&sendjob, os_getTime() + 
      ms2osticksRound(100), do_send);
  } else {
    //Serial.println((unsigned) ev);
  }
}

void setup() {
  //while (!Serial); // wait for USB
  //Serial.begin(115200);
  pinMode(LED_BUILTIN, OUTPUT);

  delay(100); // RF95 specific
  os_init();
  LMIC_reset();
  LMIC_setSession (0x13, DEVADDR, NWKSKEY, APPSKEY);

  #if defined(CFG_eu868)
  LMIC_setupChannel(0, 868100000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);
  LMIC_setupChannel(1, 868300000, DR_RANGE_MAP(DR_SF12, DR_SF7B), BAND_CENTI);
  LMIC_setupChannel(2, 868500000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);
  LMIC_setupChannel(3, 867100000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);
  LMIC_setupChannel(4, 867300000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);
  LMIC_setupChannel(5, 867500000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);
  LMIC_setupChannel(6, 867700000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);
  LMIC_setupChannel(7, 867900000, DR_RANGE_MAP(DR_SF12, DR_SF7),  BAND_CENTI);
  LMIC_setupChannel(8, 868800000, DR_RANGE_MAP(DR_FSK,  DR_FSK),  BAND_MILLI);
  #else
  #error Region not supported
  #endif

  LMIC_setLinkCheckMode(0);
  LMIC.dn2Dr = DR_SF9; // TTN RX2 window
  LMIC_setDrTxpow(DR_SF7,14);

  do_send(&sendjob);
}

void loop() {
    os_runloop_once();
}
