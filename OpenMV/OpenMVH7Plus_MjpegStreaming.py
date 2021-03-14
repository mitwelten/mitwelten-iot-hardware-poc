# https://fhnw.mit-license.org/

# Based on https://github.com/openmv/openmv/blob/master/scripts/examples/OpenMV/14-WiFi-Shield/mjpeg_streamer.py
# Licensed under MIT License, https://github.com/openmv/openmv/blob/master/LICENSE

# MJPEG Streaming Example
# NOTE: Disable IDE preview

import sensor, image, time, network, usocket, sys

SSID = 'MY_SSID'
PWRD = 'MY_PASSWORD'
HOST = '' # any
PORT = 8080

def start_streaming(s):
    print ('Accepting clients...')
    client, addr = s.accept()
    client.settimeout(2.0) # sec
    print ('Connected to ' + addr[0] + ':' + str(addr[1]))

    # Receive request
    data = client.recv(1024) # TODO: read to end of headers, \r\n\r\n

    # Send multipart response header
    client.send("HTTP/1.1 200 OK\r\n" \
                "Server: OpenMV\r\n" \
                "Content-Type: multipart/x-mixed-replace;boundary=openmv\r\n" \
                "Cache-Control: no-cache\r\n" \
                "Pragma: no-cache\r\n\r\n")

    # Start streaming images
    clock = time.clock()
    while (True):
        clock.tick()
        frame = sensor.snapshot()
        cframe = frame.compressed(quality=50)
        header = "\r\n--openmv\r\n" \
                 "Content-Type: image/jpeg\r\n"\
                 "Content-Length:" + str(cframe.size()) + "\r\n\r\n"
        client.send(header)
        client.send(cframe)
        print(clock.fps())

def is_connected():
    ip = wlan.ifconfig()[0];
    return ip != '0.0.0.0';

sensor.reset()
sensor.set_framesize(sensor.SVGA) # HD => MemoryError
sensor.set_pixformat(sensor.RGB565) # or GRAYSCALE

print("Connecting to network " + SSID + '...')
wlan = network.WINC()
while not is_connected():
    wlan.connect(SSID, key=PWRD, security=wlan.WPA_PSK)
    time.sleep(1) # sec

print("Connected, ", wlan.ifconfig())

s = usocket.socket(usocket.AF_INET, usocket.SOCK_STREAM)
s.bind([HOST, PORT])
s.listen(5)
s.setblocking(True)

while (True):
    try:
        start_streaming(s) # TODO: move connecting here as well
    except OSError as e:
        print("socket error: ", e)
        #sys.print_exception(e)
