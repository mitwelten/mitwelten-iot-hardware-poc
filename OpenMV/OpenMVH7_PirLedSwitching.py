# https://fhnw.mit-license.org/

import pyb, utime
from pyb import LED
from pyb import Pin

PIR_PIN = Pin.board.P4
RED_LED_ID = 1

button = Pin(PIR_PIN, Pin.IN)
led = LED(RED_LED_ID);

while (True):
    active = pir.value()
    print(active);
    if (active):
        led.on()
    else:
        led.off()
    utime.sleep_ms(100)
