#!/bin/sh

cd ~
git clone https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver.git
wget -O start_server.sh https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCamHighRes/start_server.sh
pip3 install v4l2-fix
sudo apt install -y python3-kms++
pip3 install flask
pip3 install flask_httpauth

cd ~
mkdir staticserver
cd staticserver
cp /home/pi/Arducam-Pivariety-V4L2-Driver/focus/Focuser.py /home/pi/staticserver
cp /home/pi/Arducam-Pivariety-V4L2-Driver/focus/v4l2_utils.py /home/pi/staticserver
wget -O /home/pi/staticserver/server.py https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCamHighRes/server.py

sudo wget -O /etc/systemd/system/staticserver.service https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/PoEPiCamHighRes/staticserver.service

sudo systemctl daemon-reload
sudo systemctl enable staticserver.service
sudo systemctl start staticserver.service

systemctl is-active --quiet staticserver.service && echo staticserver service is running || echo staticserver service is not running
