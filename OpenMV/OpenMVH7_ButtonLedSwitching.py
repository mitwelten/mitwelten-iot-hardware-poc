# https://fhnw.mit-license.org/

# Button on GND, P4

import pyb, utime
from pyb import LED
from pyb import Pin

BUTTON_PIN = Pin.board.P4
RED_LED_ID = 1

button = Pin(BUTTON_PIN, Pin.IN, Pin.PULL_UP)
led = LED(RED_LED_ID);

while (True):
    pressed = not button.value() # inverted
    print(pressed);
    if (pressed):
        led.on()
    else:
        led.off()
    utime.sleep_ms(100)
