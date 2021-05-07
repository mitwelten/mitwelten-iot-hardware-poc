# PoE Pi Cam
## Setup
### Prepare SD Card
On the computer
- Install [Raspberry Pi Imager](https://www.raspberrypi.org/software/)
- Select _Raspberry Pi OS (other)_ > _Raspberry Pi OS Lite (32-bit)_
- Click _Choose SD Card_, then _Write_
- Remove, re-insert SD Card
- To enable SSH, type
    ```
    $ touch /Volumes/boot/ssh
    ```

### Prepare Raspberry Pi 3B+
On the Pi
- Insert prepared SD Card
- Add PoE hat hardware extension
- Connect to Ethernet via RJ45 with PoE

On the computer
- Connect to AP Router Wi-Fi to access AP LAN
- Log into AP Router at http://192.168.1.1/ 
- Check _Advanced_ > _Wi-Fi_ to find LOCAL_IP
- Log into Pi via SSH (pw: raspberry)
    ```
    $ ssh pi@LOCAL_IP
    ```

On the Pi
- Change the password
    ```
    $ passwd
    ```
- Expand the filesystem
    ```
    $ sudo raspi-config # Advanced Options > Expand Filesystem
    ```
- Enable the Pi Cam
    ```
    $ sudo raspi-config # Interface Options > Camera
    ```
- Install GPAC (for MP4Box)
    ```
    $ sudo apt install -y gpac
    ```
- [Install Yaler](https://yaler.net/raspberrypi) (or an [alternative](https://alternativeto.net/software/yaler/)) and enable [SSH access](https://yaler.net/raspberrypi#SSH)

## Test the connection
On the Pi
- Run a speed test
    ```
    $ curl -Lo speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
    $ chmod +x speedtest-cli
    $ ./speedtest-cli
    ```

## Test the Pi cam
On the Pi
- Take a picture (add `-hf -vf` to flip it)
    ```
    $ raspistill -o ./cam.jpg
    ```
- Record a video (add `-hf -vf` to flip it)
    ```
    $ raspivid -t 60000 -w 640 -h 480 -fps 5 -b 1200000 -p 0,0,640,480 -o video.h264
    ```
- Convert the video to MP4
    ```
    $ MP4Box -add video.h264 video.mp4
    ```

On the computer
- Get the picture and video via SSH with SCP (via Yaler)
    ```
    $ scp -P 10023 -o ServerAliveInterval=5 pi@localhost:~/cam.jpg ~/Desktop/cam.jpg
    $ scp -P 10023 -o ServerAliveInterval=5 pi@localhost:~/video.mp4 ~/Desktop/video.mp4
    ```
