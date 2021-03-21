import pyb, utime
from pyb import LED
from pyb import Pin

SWITCH_PIN = Pin.board.P4
RED_LED_ID = 1

switch = Pin(SWITCH_PIN, Pin.IN, Pin.PULL_UP)
led = LED(RED_LED_ID);

while (True):
    active = not switch.value() # inverted
    print(active);
    if (active):
        led.on()
    else:
        led.off()
    utime.sleep_ms(100)
