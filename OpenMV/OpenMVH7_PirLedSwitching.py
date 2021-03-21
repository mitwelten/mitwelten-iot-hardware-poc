# https://fhnw.mit-license.org/

# PIR sensor on GND, 3.3V, P4

import pyb, utime
from pyb import LED, Pin

PIR_PIN = Pin.board.P4
RED_LED_ID = 1

pir = Pin(PIR_PIN, Pin.IN)
led = LED(RED_LED_ID);

while (True):
    active = pir.value()
    print(active);
    if (active):
        led.on()
    else:
        led.off()
    utime.sleep_ms(100)
