# https://fhnw.mit-license.org/

# Based on https://github.com/openmv/openmv/blob/master/scripts/examples/OpenMV/10-Color-Tracking/single_color_grayscale_blob_tracking.py
# Licensed under MIT License, https://github.com/openmv/openmv/blob/master/LICENSE

# Single Color Grayscale Blob Tracking Example

import sensor, image, time, math

# Color Tracking Thresholds (Grayscale Min, Grayscale Max)
thresholds = (5, 35)
sensor.reset()
sensor.set_pixformat(sensor.GRAYSCALE)
sensor.set_framesize(sensor.VGA)
sensor.skip_frames(time = 2000)
sensor.set_auto_gain(False) # must be turned off for color tracking
sensor.set_auto_whitebal(False) # must be turned off for color tracking
clock = time.clock()

# Only blobs that with more pixels than "pixel_threshold" and more area than "area_threshold" are
# returned by "find_blobs" below. And "merge=True" merges all overlapping blobs in the image.
n = 128
old_x = [0] * n
old_y = [0] * n
old_i = 0
while(True):
    clock.tick()
    img = sensor.snapshot()
    for blob in img.find_blobs([thresholds], pixels_threshold=10, area_threshold=10, merge=True):
        img.draw_rectangle(blob.rect(), color=127)
        img.draw_cross(blob.cx(), blob.cy(), color=127)
        old_x[old_i] = blob.cx()
        old_y[old_i] = blob.cy()
        old_i = (old_i + 1) % n
        # Blob rotation is unique to 0-180 only.
        img.draw_keypoints([(blob.cx(), blob.cy(), int(math.degrees(blob.rotation())))], size=40, color=127)
    for i in range(0, n):
        img.draw_circle(old_x[i], old_y[i], 0, 32, 3)
    # Cleanup one old dot per frame
    old_x[old_i] = 0;
    old_y[old_i] = 0;
    old_i = (old_i + 1) % n
    print(clock.fps())
