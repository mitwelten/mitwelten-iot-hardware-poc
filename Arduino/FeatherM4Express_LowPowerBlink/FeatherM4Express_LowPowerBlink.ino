// https://tamberg.mit-license.org/

#include <Adafruit_SleepyDog.h>

void lowPowerDelay(int ms) {
  int dms;
  do {
    dms = Watchdog.sleep(ms);
    ms -= dms;
  } while (ms > 0);
}

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  lowPowerDelay(100);
  digitalWrite(LED_BUILTIN, LOW);
  lowPowerDelay(1900);
}
