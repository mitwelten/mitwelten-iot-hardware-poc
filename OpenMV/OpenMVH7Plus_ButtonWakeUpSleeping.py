# https://fhnw.mit-license.org/

# Based on https://github.com/openmv/openmv/tree/master/scripts/examples/OpenMV/19-Low-Power
# Licensed under MIT License, https://github.com/openmv/openmv/blob/master/LICENSE

# Button on GND, P4, wakes device up from deep sleep

import time, pyb, machine
from pyb import Pin, ExtInt

BUTTON_PIN = Pin.board.P4
RED_LED_ID = 1

def blink_n(n):
    while (n > 0):
        led.on()
        time.sleep_ms(100)
        led.off()
        time.sleep_ms(100)
        n = n - 1

def callback(line):
    pass

led = pyb.LED(RED_LED_ID)
btn = Pin(BUTTON_PIN, Pin.IN, Pin.PULL_UP)
ext = ExtInt(btn, ExtInt.IRQ_FALLING, Pin.PULL_UP, callback)

n = 0
while (True):
    blink_n(n)
    n = n + 1 # n will be preserved
    machine.sleep() # IDE will disconnect
