# Simple video stream

*Raspberry PI 3B+*


*Raspberry PI OS Lite*

## Setup

```sh
# Install ffmpeg
sudo apt install ffmpeg

# Clone, make and install StreamEye
git clone https://github.com/ccrisan/streameye.git
cd streameye
make
sudo make install
```

## Usage

Find camera device
```sh
ls -la /dev/video*

# you should see two video devices with number<10
crw-rw---- 1 root video 81, 7 Mar 25 13:28 /dev/video0
crw-rw---- 1 root video 81, 8 Mar 25 13:28 /dev/video1
crw-rw---- 1 root video 81, 4 Feb 12 16:28 /dev/video10
crw-rw---- 1 root video 81, 5 Feb 12 16:28 /dev/video11
crw-rw---- 1 root video 81, 6 Feb 12 16:28 /dev/video12
crw-rw---- 1 root video 81, 0 Feb 12 16:28 /dev/video13
crw-rw---- 1 root video 81, 1 Feb 12 16:28 /dev/video14
crw-rw---- 1 root video 81, 2 Feb 12 16:28 /dev/video15
crw-rw---- 1 root video 81, 3 Feb 12 16:28 /dev/video16
```

Start the stream
```sh
ffmpeg -f video4linux2 -i /dev/video0 -r 30 -s 640x480 -f mjpeg -qscale 5 - 2>/dev/null | streameye -p 8081
```

See the stream
- open a webbrowser
- go to `<RaspberryPi_IP>:8081`
- or `http://raspberrypi.local:8081/`

### Parameters

**FFMPEG**

Name|description
-|-
-i|Camera device
-r|Frames per second
-s|Resolution
-f|Format
-qscale|Quality (from 1 to 31 where 1 is the best quality)

**StreamEye**
Name|description
-|-
-p|port

> Use different ports to stream from multiple cameras simultaneously
