# https://fhnw.mit-license.org/

# Based on https://github.com/openmv/openmv/tree/master/scripts/examples/OpenMV/19-Low-Power
# Licensed under MIT License, https://github.com/openmv/openmv/blob/master/LICENSE

# Button on GND, P4 - triggers external interrupt to wake device up from stop mode.

import time, pyb, machine
from pyb import Pin, ExtInt, LED

BUTTON_PIN = Pin.board.P4
RED_LED_ID = 1

def callback(line):
    pass

def blink(n):
    while (n > 0):
        led.on()
        time.sleep_ms(100)
        led.off()
        time.sleep_ms(100)
        n = n - 1

led = LED(RED_LED_ID)
btn = Pin(BUTTON_PIN, Pin.IN, Pin.PULL_UP)
ext = ExtInt(btn, ExtInt.IRQ_FALLING, Pin.PULL_UP, callback)

n = 0
while (True):
    blink(n)
    n = n + 1 # n will be preserved
    machine.sleep() # IDE will disconnect
