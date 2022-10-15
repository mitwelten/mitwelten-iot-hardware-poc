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

### Prepare Raspberry Pi 3B+ (or Pi Zero W)
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
- Set the hostname to _cam-0000-0000_ (using the [deploy.mitwelten.org](https://deploy.mitwelten.org/) node ID)
    ```
    $ sudo raspi-config # System Options > Hostname
    ```
- Expand the filesystem
    ```
    $ sudo raspi-config # Advanced Options > Expand Filesystem
    ```
- Enable the Pi Cam
    ```
    $ sudo raspi-config # Interface Options > Camera
    ```
- Increase GPU RAM
    ```
    $ sudo raspi-config > Performance Options > GPU Memory > 256
    ```
    > Required for highest resolution [v2 mode](https://picamera.readthedocs.io/en/latest/fov.html#sensor-modes).
- Install git
    ```
    $ sudo apt-get update
    $ sudo apt-get install git
    ```
- <s>Install GPAC (for MP4Box)</s>
    ```
    $ sudo apt install -y gpac
    ```
- <s>Install VLC (for streaming)</s>
    ```
    $ sudo apt-get install vlc
    ```
- Install mjpeg_streamer
    ```
    $ cd ~
    $ sudo apt-get install cmake libjpeg8-dev
    $ sudo apt-get install gcc g++
    $ git clone https://github.com/jacksonliam/mjpg-streamer
    $ cd mjpg-streamer
    $ cd mjpg-streamer-experimental
    $ make
    $ ./mjpg_streamer
    ```
- Install mjpg-streamer.service
    ```
    $ sudo wget -O /etc/systemd/system/mjpg-streamer.service https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCam/mjpg-streamer.service
    $ sudo wget -O /etc/systemd/system/.mjpgconf https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCam/.mjpgconf
    ```
    > Edit parameters and credentials in [.mjpgconf](.mjpgconf)
- Start mjpg-streamer.service
    ```
    sudo systemctl daemon-reload
    sudo systemctl enable mjpg-streamer.service
    sudo systemctl start mjpg-streamer.service
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
- <s>Record a video (add `-hf -vf` to flip it)</s>
    ```
    $ raspivid -t 60000 -w 640 -h 480 -fps 5 -b 1200000 -p 0,0,640,480 -o video.h264
    ```
- <s>Convert the video to MP4</s>
    ```
    $ MP4Box -add video.h264 video.mp4
    ```
- <s>Provide a video stream with VLC</s>
    ```
    $ raspivid -o - -t 0 -hf -w 800 -h 400 -fps 5 | cvlc -vvv stream:///dev/stdin --sout '#standard{access=http,mux=ts,dst=:8160}' :demux=h264
    ```
- Provide a video stream with mjpeg_streamer
    ```
    $ ./mjpg_streamer -i "input_uvc.so -r 1024x576 -d /dev/video0" -o "output_http.so -p 8080 --credentials MY_USER:MY_PASSWORD -www ./www"
    ```
On the computer
- Get the picture and video via SSH with SCP
    ```
    $ scp -P 22 -o ServerAliveInterval=5 pi@LOCAL_IP:~/cam.jpg ./
    $ scp -P 22 -o ServerAliveInterval=5 pi@LOCAL_IP:~/video.mp4 ./
    ```
    or via Yaler via SSH with [SCP](https://yaler.net/scp):
    ```
    $ scp -P 10022 -o ServerAliveInterval=5 pi@localhost:~/cam.jpg ./
    $ scp -P 10022 -o ServerAliveInterval=5 pi@localhost:~/video.mp4 ./
    ```
- Record the VLC video stream with
    ```
    $ curl http://LOCAL_IP:8160 --output ./video.h264
    ```
- Access the MJPEG video stream with
    ```
    http://LOCAL_IP:8080/?action=stream or
    http://LOCAL_IP:8080/?action=snapshot
    ```
