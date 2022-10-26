# PoE Pi Zero Arducam
## Setup

### Prepare SD Card
On the computer
- Install [Raspberry Pi Imager](https://www.raspberrypi.org/software/)
- Select _Raspberry Pi OS (other)_ > _Raspberry Pi OS Lite (32-bit)_
- Click _Choose SD Card_
- Before write, go to advanced settings and configure:
    - SSH user _pi_ with password _raspberry_
    - Custom Wi-Fi
- _Write_ image
- Remove, re-insert SD Card
- Adapt `config.txt`: Add `dtoverlay=dwc2` at the end of the file.
- Adapt `cmdline.txt`: Add `modules-load=dwc2,g_ether` directly after `rootwait`.

### Prepare Raspberry Pi Zero W
#### On the Pi:
- Insert prepared SD Card
- Add PoE hat hardware extension
- Connect to Wi-Fi. This process can take up to 2 minutes until the RPi is visible in the network.


####  On the computer:

Option 1:
- Connect to AP Router Wi-Fi to access AP LAN
- Log into AP Router at http://192.168.1.1/ 
- Check _Advanced_ > _Wi-Fi_ to find LOCAL_IP

Option 2:
- It is also possible to use tools like `nmap` (Linux) or [zenmap](https://nmap.org/zenmap/) GUI (Winwdows), to scan the network and look up the IP adress of your RPI.

----
## Configurations and Drivers

Log into Pi via SSH (pw: raspberry)
```
ssh pi@LOCAL_IP
```

On the Pi
Optional: Change the password 
```bash
passwd
```

Optional: Expand the filesystem
```bash
sudo raspi-config # Advanced Options > Expand Filesystem
```

Install Arducam driver
```bash
wget -O install_pivariety_pkgs.sh https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh
chmod +x install_pivariety_pkgs.sh
./install_pivariety_pkgs.sh -p imx519_kernel_driver_low_speed
```

Enable options on Pi
1. Open a terminal
2. Run sudo raspi-config
3. Navigate to Advanced Options
4. Enable Glamor graphic acceleration
5. Go back to Advanced Options
6. Navigate to GL Driver
7. Select GL (Full KMS)
8. Reboot your Pi


Check if the driver is detected by the system
```bash
dmesg | grep imx519
```
and now there should also be a folder named
```bash
ls /dev/video0
```

List the camera
```bash
libcamera-still --list-cameras
```

Update
```bash
sudo apt-get update
```

Check `/boot/config.txt` if there is an entry `dtoverlay=imx519` at the end of the file.
```bash
tail -n 5 /boot/config.txt
```
If there is no entry, add it manually. 

Then in the same file append following parameters at the end after `[all]`:
```bash
dtoverlay=vc4-kms-v3d,cma-128
gpu_mem=128
over_voltage=2
```

**Hint**: 
The `cma` depends on your RPI Contiguous Memory Allocation. Check how much is possible for your device with this cmd:
```bash
cat /proc/meminfo | grep Cma*  
```
Make sure that `gpu_mem` does not exceed the `MemTotal` of your device.

Reboot your device:
```bash
sudo reboot
```

### Setup of Autofocus

```bash
wget -O install_pivariety_pkgs.sh https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh
chmod +x install_pivariety_pkgs.sh
./install_pivariety_pkgs.sh -p libcamera_dev
./install_pivariety_pkgs.sh -p libcamera_apps

```
After the installations of the libcamera suite. Reboot device:
```bash
sudo reboot
```

----
## Software Installation


Install git
```
sudo apt-get update
sudo apt-get install git
```
Optional: Install GPAC (for MP4Box)
```
sudo apt install -y gpac
```
Optional: Install VLC (for streaming)
```
sudo apt-get install vlc
```

Install mjpeg_streamer
```
cd ~
sudo apt-get install cmake libjpeg8-dev
sudo apt-get install gcc g++
sudo apt-get install cmake
git clone https://github.com/jacksonliam/mjpg-streamer
cd mjpg-streamer
cd mjpg-streamer-experimental
make
./mjpg_streamer
```
Install mjpg-streamer.service
```
sudo wget -O /etc/systemd/system/mjpg-streamer.service https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCam/mjpg-streamer.service
sudo wget -O /etc/systemd/system/.mjpgconf https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCam/.mjpgconf
```
Edit parameters and credentials in [.mjpgconf](.mjpgconf)

Start mjpg-streamer.service
```
sudo systemctl daemon-reload
sudo systemctl enable mjpg-streamer.service
sudo systemctl start mjpg-streamer.service
```    
- [Install Yaler](https://yaler.net/raspberrypi) (or an [alternative](https://alternativeto.net/software/yaler/)) and enable [SSH access](https://yaler.net/raspberrypi#SSH)

## Test the connection
On the Pi
Run a speed test
```
curl -Lo speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
chmod +x speedtest-cli
./speedtest-cli
```

## Test the Camera

On the Pi

Take a picture 500x500
```bash
libcamera-jpeg -o test.jpg --width 500 --height 500
```
with autofocus:
```bash
libcamera-jpeg -o test.jpg --width 500 --height 500 --autofocus
```

Record 20s video
```bash
libcamera-vid -t 20000 --autofocus -o test_video_autofocus.h264
```
Convert video to mp4 (requires gpac to be installed)
```bash
MP4Box -add test_video_autofocus.h264 test_video_autofocus.mp4
```

Provide a video stream with mjpeg_streamer
```bash
./mjpg_streamer -i "input_uvc.so -r 1024x576 -d /dev/video0" -o "output_http.so -p 8080 --credentials MY_USER:MY_PASSWORD -www ./www"
```
On the computer
Get the picture and video via SSH with SCP
```
scp -P 22 -o ServerAliveInterval=5 pi@LOCAL_IP:~/cam.jpg ./
scp -P 22 -o ServerAliveInterval=5 pi@LOCAL_IP:~/video.mp4 ./
```
or via Yaler via SSH with [SCP](https://yaler.net/scp):
```
scp -P 10022 -o ServerAliveInterval=5 pi@localhost:~/cam.jpg ./
scp -P 10022 -o ServerAliveInterval=5 pi@localhost:~/video.mp4 ./
```
Record the VLC video stream with
```
curl http://LOCAL_IP:8160 --output ./video.h264
```
Access the MJPEG video stream with
```
http://LOCAL_IP:8080/?action=stream or
http://LOCAL_IP:8080/?action=snapshot
```


## Further Documentation
- https://github.com/raspberrypi/libcamera-apps/issues/246
- https://www.arducam.com/docs/cameras-for-raspberry-pi/raspberry-pi-libcamera-guide/
- https://github.com/raspberrypi/libcamera-apps/issues/144
- https://forum.arducam.com/t/setup-raspberry-pi-zero-with-arducam-16mp/3671
- https://www.waveshare.com/wiki/RPi_Camera_(I)
- https://www.raspberrypi.com/documentation/accessories/camera.html#libcamera-and-libcamera-apps
