# High Resolution PoE Pi Cam

## Raspberry Pi Setup

* Raspberry Pi Imager
  * &rarr; Set Hostname
  * &rarr; Set Password
  * &rarr; Select OS: Raspberry Pi OS 32 Bit lite

## Install the Software

```sh
curl https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCamHighRes/install_hrcam_part1.sh | bash
```

After the execution of the script, you will be asked if you want to reboot. Type `y`.

After the reboot, install the rest of the software:
```sh
curl https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCamHighRes/install_hrcam_part2.sh | bash
```

You can now access the camera in a web browser:

http://your-camera-hostname.local:8080

## API Description

Route|Description
-|-
`/snapshot` or `/?action=snapshot` | A full-resolution snapshot of the camera
`/center` | The center of the image, used for focussing
`/focus` | A simple form to set the focus value

## Configuration

Edit `start_server.sh`
```sh
nano /home/pi/start_server.sh
```
Following parameters can be configured:

Parameter|Value|Default
-|-|-
QUALITY|JPEG image quality|90
PORT|Port to listen on|8080
USERNAME|Basic Auth username|MY_USER
PASSWORD|Basic Auth password|MY_PASSWORD
WIDTH|Image width|4656
HEIGHT|Image height|3496

Apply changes by restarting the systemd service:
```sh
sudo systemctl restart staticserver.service
```
