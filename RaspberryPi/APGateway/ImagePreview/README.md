# Image preview

## Dependencies

```sh
sudo apt-get install libopenjp2-7
sudo apt install libtiff5
sudo apt install python3-pip
```
```sh
pip3 install flask
pip3 install pillow
pip3 install Flask-HTTPAuth
```

## Install it

```sh
mkdir ImagePreview
cd ImagePreview
# download app.py
wget https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/APGateway/ImagePreview/app.py

mkdir templates
cd templates
# download html templates
wget https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/APGateway/ImagePreview/templates/index.html
wget https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/APGateway/ImagePreview/templates/preview.html
wget https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/APGateway/ImagePreview/templates/selectday.html
wget https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/APGateway/ImagePreview/templates/selecthour.html
```

## Run it

```sh
cd ~/ImagePreview
python3 app.py
```
