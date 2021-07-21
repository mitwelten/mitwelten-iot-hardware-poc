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

## Set the password

```sh
nano ~/.bash_profile
```

Add the password to `.bash_profile`:

```sh
export IMAGEPREVIEW_PASSWORD=yourpassword
```

Add the variable
```sh
source ~/.bash_profile
```

## Run it

```sh
cd ~/ImagePreview
python3 app.py
```
