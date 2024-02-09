# Unfinished Pi-based PoC
- [Raspberry Pi Streaming Camera](#raspberry-pi-streaming-camera)
- [Raspberry Pi Streaming Camera with Solar Power](#raspberry-pi-streaming-camera-with-solar-power)
- [Raspberry Pi Streaming Endoscope](#raspberry-pi-streaming-endoscope)

## Raspberry Pi Streaming Camera
This Raspberry Pi camera provides a basic video stream.

### Software
- [StreamEye](https://github.com/ccrisan/streameye)
- [FFmpeg](https://www.ffmpeg.org/)

### Hardware
- [Raspberry Pi 3 B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Camera](https://www.raspberrypi.org/products/camera-module-v2/)

### Setup
- [StreamEye Setup](RaspberryPi/StreamEye/README.md)

## Raspberry Pi Streaming Camera with Solar Power
Same as [Raspberry Pi Streaming Camera](#raspberry-pi-streaming-camera), with additional solar power.

Based on [this example](https://github.com/danjulio/MPPT-Solar-Charger/tree/master/examples/enclosure) by [@danjulio](https://github.com/danjulio), with local suppliers.

### Hardware
- [MPPT Solar Charger](https://www.tindie.com/products/globoy/mppt-solar-charger-for-intelligent-devices/)
- [12V, 30W, 36 Cell Solar Panel](https://www.conrad.ch/de/p/phaesun-sun-plus-30-s-monokristallines-solarmodul-30-w-12-v-2178372.html)
- [12V, 9Ah, Sealed Lead Battery](https://www.conrad.ch/de/p/conrad-energy-12-v-9-ah-250915-bleiakku-12-v-9-ah-blei-vlies-agm-b-x-h-x-t-151-x-94-x-65-mm-flachstecker-6-35-mm-war-250915.html)
- [12V Battery Charger](https://www.conrad.ch/de/p/h-tronic-bleiakku-ladegeraet-al600plus-2-v-6-v-12-v-ladestrom-max-0-6-a-512315.html) (optional)
- [Black 1.5mm Wire](https://www.conrad.ch/de/p/conrad-components-606241-fahrzeugleitung-flry-b-1-x-1-50-mm-schwarz-10-m-606241.html)
- [Red 1.5mm Wire](https://www.conrad.ch/de/p/conrad-components-606216-fahrzeugleitung-flry-b-1-x-1-50-mm-rot-10-m-606216.html)
- [Blue Connector](https://www.conrad.ch/de/p/vogt-verbindungstechnik-3905-flachsteckhuelse-steckbreite-4-8-mm-steckdicke-0-8-mm-180-teilisoliert-blau-1-st-736957.html)
- [Red Connector](https://www.conrad.ch/de/p/vogt-verbindungstechnik-3902-flachsteckhuelse-steckbreite-4-8-mm-steckdicke-0-8-mm-180-teilisoliert-rot-1-st-736933.html)

### Enclosure
- [IP67 Box with Clear Lid](https://www.mouser.ch/ProductDetail/Bud-Industries/PIP-11774-C/?qs=%2Fha2pyFaduhWtJcHf4Wic0ePltHJ10nv%252BRGIcnz2UHY8U4iCR362lHUokvZ%252BawDliJqYr5a2Kxo%3D)
- Laser-cut [Box Fixture](https://github.com/danjulio/MPPT-Solar-Charger/tree/master/examples/enclosure) by [@danjulio](https://github.com/danjulio)

## Raspberry Pi Streaming Endoscope
Same as [Raspberry Pi Streaming Camera](#raspberry-pi-streaming-camera), but with a USB endoscope.

<img src="https://live.staticflickr.com/65535/50979064987_da8b5c72d7.jpg"/>

### Hardware
- [USB endoscope](https://de.aliexpress.com/item/32954115464.html?spm=a2g0s.9042311.0.0.27424c4dtKIQ4i)
