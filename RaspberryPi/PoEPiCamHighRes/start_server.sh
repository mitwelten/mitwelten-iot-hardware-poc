#!/bin/sh
QUALITY=90
PORT=8080
USERNAME=MY_USER
PASSWORD=MY_PASSWORD
WIDTH=4656
HEIGHT=3496

cd /home/pi/staticserver
python3 server.py --port $PORT --username $USERNAME --password $PASSWORD --quality $QUALITY --width $WIDTH --height $HEIGHT
