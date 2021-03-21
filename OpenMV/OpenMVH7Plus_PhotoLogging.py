# https://fhnw.mit-license.org/

# Based on https://github.com/openmv/openmv/tree/master/scripts/examples/OpenMV/05-Snapshot
# Based on https://github.com/openmv/openmv/blob/master/scripts/examples/OpenMV/19-Low-Power
# Licensed under MIT License, https://github.com/openmv/openmv/blob/master/LICENSE

import machine, sensor, image, pyb

RED_LED_ID = 1

led = pyb.LED(RED_LED_ID)
rtc = pyb.RTC()
#if (machine.reset_cause() is not machine.DEEPSLEEP_RESET):
rtc.datetime((2021, 3, 22, 1, 0, 11, 0, 0)) # When connecting LiPo

led.on()
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.WQXGA2)
sensor.skip_frames(time = 2000) # Let settings take effect
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
sensor.sleep(True)
sensor.shutdown(True)
rtc.wakeup(20000) # ms
led.off()
machine.deepsleep() # ~0.00 A, device will be reset on wakeup
