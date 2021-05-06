# APGateway
## Setup
### Prepare SD Card
- On the computer, install [Raspberry Pi Imager](https://www.raspberrypi.org/software/)
- Select _Raspberry Pi OS (other)_ > _Raspberry Pi OS Lite (32-bit)_
- Click _Choose SD Card_, then _Write_
- Remove, re-insert SD Card, type
    ```
    $ touch /Volumes/boot/ssh
    ```

### Prepare Raspberry Pi
- Insert prepared SD Card
- Connect to power via USB-C
- Connect to Ethernet via RJ45
- Share Computer Wi-Fi to Ethernet
- From the computer, login via SSH (pw: raspberry)
    ```
    $ ssh pi@raspberrypi.local
    ```
- On the Pi, change the password with
    ```
    $ passwd
    ```
- Expand the filesystem
    ```
    $ sudo raspi-config # Advanced Options > Expand Filesystem
    ```
- Mount the hard disk
    ```
    # TODO
    ```
- Install [Yaler](https://yaler.net/raspberrypi) for remote access (optional)
