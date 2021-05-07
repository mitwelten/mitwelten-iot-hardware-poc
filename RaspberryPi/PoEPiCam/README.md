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
- Install [Yaler](https://yaler.net/raspberrypi) for remote SSH access (optional)
