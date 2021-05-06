# APGateway
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

### Prepare Raspberry Pi 4B
On the Pi
- Insert prepared SD Card
- Connect to power via USB-C
- Connect to Ethernet via RJ45

On the computer
- Share Computer Wi-Fi to Ethernet
- Log into Pi via SSH (pw: raspberry)
    ```
    $ ssh pi@raspberrypi.local
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
- Enable the fan
    ```
    $ sudo nano /boot/config.txt
    ...
    dtoverlay=gpio-fan,gpiopin=18,temp=55000
    ```
- Mount the hard disk
    ```
    # [TODO](https://www.raspberrypi.org/documentation/configuration/external-storage.md)
    ```
- Install [Yaler](https://yaler.net/raspberrypi) for remote SSH access (optional)
