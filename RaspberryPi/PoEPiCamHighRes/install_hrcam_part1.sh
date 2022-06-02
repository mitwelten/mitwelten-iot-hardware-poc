#!/bin/sh
sudo apt update 
sudo apt upgrade -y
sudo apt install -y git python3-pip python3-pyqt5
sudo apt install -y python3-prctl libatlas-base-dev ffmpeg libopenjp2-7
pip3 install numpy --upgrade
NOGUI=1 pip3 install picamera2

wget -O install_pivariety_pkgs.sh https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh
chmod +x install_pivariety_pkgs.sh

./install_pivariety_pkgs.sh -p libcamera_dev

./install_pivariety_pkgs.sh -p libcamera_apps

./install_pivariety_pkgs.sh -p imx519_kernel_driver
