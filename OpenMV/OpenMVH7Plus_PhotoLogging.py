# https://fhnw.mit-license.org/

# Based on https://github.com/openmv/openmv/tree/master/scripts/examples/OpenMV/05-Snapshot
# Licensed under MIT License, https://github.com/openmv/openmv/blob/master/LICENSE

# Photo Logging Example

import utime, sensor, image, pyb

RED_LED_PIN = 1
BLUE_LED_PIN = 3

pyb.LED(RED_LED_PIN).on()
rtc = pyb.RTC()
rtc.datetime((2021, 3, 11, 4, 22, 45, 0, 0))
# https://docs.openmv.io/library/omv.sensor.html
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.WQXGA2) # VGA for H7
sensor.skip_frames(time = 2000) # Let settings take effect
pyb.LED(RED_LED_PIN).off()
while True:
    pyb.LED(BLUE_LED_PIN).on()
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
    pyb.LED(BLUE_LED_PIN).off()
    utime.sleep(20) # s, 0.18 A
