# https://fhnw.mit-license.org/

# Based on https://github.com/openmv/openmv/tree/master/scripts/examples/OpenMV/05-Snapshot
# Licensed under MIT License, https://github.com/openmv/openmv/blob/master/LICENSE

# Photo Logging Example

import utime, sensor, image, pyb, machine
from pyb import Pin, ExtInt, LED, RTC

PIR_PIN = Pin.board.P4
RED_LED_ID = 1

def callback(line):
    pass

led = LED(RED_LED_ID)
pir = Pin(PIR_PIN, Pin.IN)
ext = ExtInt(pir, ExtInt.IRQ_RISING, Pin.PULL_NONE, callback)

led.on()
rtc = RTC()
rtc.datetime((2021, 3, 21, 7, 17, 00, 0, 0)) # When connecting LiPo
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.WQXGA2)
sensor.skip_frames(time = 2000) # Let settings take effect
led.off()
while True:
    led.on()
    t = rtc.datetime()
    y = str(t[0])
    m = '%02d' % t[1]
    d = '%02d' % t[2]
    # w = '%d' % t[3]
    h = '%02d' % t[4]
    n = '%02d' % t[5]
    s = '%02d' % t[6]
    name = 'snapshot_' + y + '-' + m + '-' + d + 'T' + h + '-' + n + '-' + s + 'Z.jpg'
    sensor.snapshot().save(name) # 0.25 A
    led.off()
    machine.sleep() # until external interrupt triggered by PIR, 0.06 A
