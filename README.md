# Mitwelten.org IoT Hardware Proof of Concept

Work in progress. Questions? Contact [mitwelten.technik@fhnw.ch](mailto:mitwelten.technik@fhnw.ch)

- [AudioMoth Audio Logging Microphone](#audiomoth-audio-logging-microphone)
- [LoRaWAN Gateway with 3G Uplink](#lorawan-gateway-with-3g-uplink)
- [LoRaWAN Sensor Nodes](#lorawan-sensor-nodes)
- [LoRaWAN Sensor Nodes with Power](#lorawan-sensor-nodes-with-solar-power)
- [OpenMV Bug Tracking Camera](#openmv-bug-tracking-camera)
- [OpenMV Photo Logging Camera](#openmv-photo-logging-camera)
- [OpenMV Photo Logging Camera with PIR](#openmv-photo-logging-camera-with-pir)
- [OpenMV Video Streaming Camera](#openmv-video-streaming-camera)
- [Raspberry Pi Streaming Camera](#raspberry-pi-streaming-camera)
- [Raspberry Pi Streaming Camera with PoE](#raspberry-pi-streaming-camera-with-poe)
- [Raspberry Pi Streaming Camera with Solar Power](#raspberry-pi-streaming-camera-with-solar-power)
- [Raspberry Pi Streaming Endoscope](#raspberry-pi-streaming-endoscope)
- [Wi-Fi and PoE Access Point with 4G Uplink](#wi-fi-and-poe-access-point-with-4g-uplink)

## LoRaWAN Sensor Nodes
These LoRaWAN sensor nodes can send small amounts (< 52 bytes) of data with a low frequency (1 per 15+ min) over long distances (1+ km).

<img src="https://live.staticflickr.com/65535/50949785202_b05df960fc.jpg"/>

<img src="https://live.staticflickr.com/65535/50938710327_e62cc90963.jpg"/>

<img src="https://live.staticflickr.com/65535/50946175397_5f748fea67.jpg"/>

### Software
- [FeatherM4Express_TtnVBattDHT11.ino](Arduino/FeatherM4Express_TtnVBattDHT11/FeatherM4Express_TtnVBattDHT11.ino)
- [FeatherM4Express_TtnVBattMoisture.ino](Arduino/FeatherM4Express_TtnVBattMoisture/FeatherM4Express_TtnVBattMoisture.ino)
- FeatherM4Express_TtnVBattButton.ino (TODO)
- FeatherM4Express_TtnVBattPIR.ino (TODO)

### Hardware
- [Feather M4 Express](https://github.com/tamberg/fhnw-iot/wiki/Feather-M4-Express)
- [FeatherWing RFM95W](https://github.com/tamberg/fhnw-iot/wiki/FeatherWing-RFM95W)
- [Grove Adapter](https://github.com/tamberg/fhnw-iot/wiki/Grove-Adapters#grove-shield-for-feather)
- [DHT11](https://www.seeedstudio.com/Grove-Temperature-Humidity-Sensor-DHT11.html) or [Soil Moisture](https://www.seeedstudio.com/Grove-Capacitive-Moisture-Sensor-Corrosion-Resistant.html) or other [Grove Sensors](https://github.com/tamberg/fhnw-iot/wiki/Various#sensors)
- [3.7V, 2000 mAh LiPo Battery](https://de.aliexpress.com/wholesale?catId=0&initiative_id=SB_20191122074854&origin=y&SearchText=103450) (JST 2, check polarity)

### Enclosure
- [AP9 Junction Box](https://new.abb.com/products/2TKA140012G1/ap9-junction-box-ip65)
- [AP9 Template](https://www.thingiverse.com/thing:3638252) and [Remixes](https://www.thingiverse.com/thing:3638252/remixes) by [@tamberg](https://www.thingiverse.com/tamberg/designs), CC BY-SA
- [AP9 Fixture](https://www.thingiverse.com/thing:4762526) by [@tamberg](https://www.thingiverse.com/tamberg/designs), CC BY-SA
- [PVC Tube](https://www.bauundhobby.ch/maschinen-werkstatt/elektro-material/verlegware/rohre/rohr-kir-m20-grau-2-m/p/4002432)

### Setup
- [Arduino IDE](https://www.arduino.cc/en/software)
- [TTN Console](https://console.thethingsnetwork.org/)
- [ThingSpeak](https://thingspeak.com/)

### Data
- https://thingspeak.com/channels/1130641

## LoRaWAN Sensor Nodes with Solar Power
Same as [LoRaWAN Sensor Nodes](#lorawan-sensor-nodes), with additional solar power.

<img src="https://live.staticflickr.com/65535/50975641601_07fd28bbbd.jpg"/>

<img src="https://live.staticflickr.com/65535/50975754157_050c9cbf8d.jpg"/>

### Hardware
- [6V, 1W Solar Panel](https://www.adafruit.com/product/3809)
- [USB, Solar, LiPo Charger](https://www.adafruit.com/product/4755)
- [3.5/1.1mm to 5.5/2.1mm Jack Adapter](https://www.adafruit.com/product/4287)
- [4700uF 10v Electrolytic Capacitor](https://www.adafruit.com/product/1589) (optional)
- [10K Precision Epoxy Thermistor](https://www.adafruit.com/product/372)(optional)

## LoRaWAN Gateway with 3G Uplink
This LoRaWAN gateway provides Internet-connectivity to LoRaWAN sensor nodes over a long range (1+ km).

<img src="https://live.staticflickr.com/65535/50949786697_853167d179.jpg"/>

### Hardware
- [Geneko GWR352-EM770W](https://www.geneko.rs/en/products/m2m-products-and-solutions/gwr-cellular-router-series/gwr352-3g-router)
- [Raspberry Pi 3 B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [IMST iC880a SPI](https://shop.imst.de/wireless-modules/lora-products/8/ic880a-spi-lorawan-concentrator-868-mhz)
- [Antenna](https://shop.imst.de/wireless-modules/accessories/19/sma-antenna-for-ic880a-spi-wsa01-im880b-and-lite-gateway)
- [Pigtail](https://shop.imst.de/wireless-modules/accessories/20/u.fl-to-sma-pigtail-cable-for-ic880a-spi)
- [Power Supply](https://www.raspberrypi.org/products/raspberry-pi-universal-power-supply/)
- Jumper Wires F-F
- RJ45 Cable
- SIM Card

### Enclosure
- [AP10 Junction Box](https://new.abb.com/products/2TKA140002G1/ap10-junction-box-ip65)
- [AP10 Adapter](https://www.thingiverse.com/thing:1665467) by [@tamberg](https://www.thingiverse.com/tamberg/designs), CC BY-SA

### Setup
- [TTN Console](https://console.thethingsnetwork.org/)
- http://192.168.1.1/
- SIM Provider Backend

## AudioMoth Audio Logging Microphone
This audio logging microphone can record and store a broad range of frequencies, triggered by time of day or loudness.

<img src="https://live.staticflickr.com/65535/50949169428_b02b0b8b92.jpg"/>

<img src="https://live.staticflickr.com/65535/50926837493_deef6a66f1.jpg"/>

### Hardware
- https://www.openacousticdevices.info/audiomoth
- 3 * AA Batteries
- Micro SD Card (ExFAT)

### Enclosure
- [AudioMoth Vault](https://www.thingiverse.com/thing:4546491) by [@brandonh](https://www.thingiverse.com/brandonh), CC BY-NC-SA
- [Membrane](https://www.alibaba.com/product-detail/Customized-IP67-protective-vent-waterproof-acoustic_62076766363.html)
- [Magnets](https://www.supermagnete.ch/scheibenmagnete-neodym/scheibenmagnet-6mm-3mm_S-06-03-N)
- [Glue](https://www.supermagnete.ch/werkstatt-magnete/uhu-max-repair_WS-ADH-01)

### Setup
- [AudioMoth Desktop App](https://www.openacousticdevices.info/applications)
- [Sonic Visualiser](https://sonicvisualiser.org/download.html)

## OpenMV Photo Logging Camera
This photo logging camera allows to continuously take snapshots in an outdoor setting.

<img src="https://live.staticflickr.com/65535/51013775987_e3de2c364e.jpg"/>

### Software
- [OpenMVH7_PhotoLogging.py](OpenMV/OpenMVH7_PhotoLogging.py)
- [OpenMVH7Plus_PhotoLogging.py](OpenMV/OpenMVH7Plus_PhotoLogging.py) (Deep Sleep)

### Hardware
- [OpenMV Cam H7](https://openmv.io/collections/products/products/openmv-cam-h7)
- [3.7V, 6600 mAh, LiIon Battery](https://www.adafruit.com/product/353) (JST 2, check polarity)
- Micro SD Card (ExFAT)

### Enclosure
- [IoT Brick OpenMV Cam H7](https://www.thingiverse.com/thing:4787263)

### Setup
- [OpenMV IDE](https://openmv.io/pages/download)

## OpenMV Photo Logging Camera with PIR
This photo logging camera allows to take snapshots in an outdoor setting when something moves.

<img src="https://live.staticflickr.com/65535/51059049837_77f5a53bda.jpg"/>

### Software
- [OpenMVH7Plus_PirWakeUpPhotoLogging.py](OpenMV/OpenMVH7Plus_PirWakeUpPhotoLogging.py)

### Hardware
- [OpenMV Cam H7 Plus](https://openmv.io/collections/products/products/openmv-cam-h7-plus)
- [Proto Shield](https://openmv.io/collections/shields/products/proto-shield)
- [PIR Motion Sensor](https://www.adafruit.com/product/189)
- [3.7V, 6600 mAh, LiIon Battery](https://www.adafruit.com/product/353) (JST 2, check polarity)
- Micro SD Card (ExFAT)

### Enclosure
- TODO

### Setup
- [OpenMV IDE](https://openmv.io/pages/download)

## OpenMV Bug Tracking Camera
This bug tracking camera allows to track small blobs (pepper corn or bigger) in a lab setting.

<img src="https://live.staticflickr.com/65535/50950426063_26e88a4d96.jpg"/>

### Software
- [OpenMVH7_BlobTracking.py](OpenMV/OpenMVH7_BlobTracking.py)

### Hardware
- [OpenMV Cam H7](https://openmv.io/collections/products/products/openmv-cam-h7)

### Enclosure
- TODO

### Setup
- [OpenMV IDE](https://openmv.io/pages/download)

## OpenMV Video Streaming Camera
This video streaming camera provides a basic video stream.

<img src="https://live.staticflickr.com/65535/51037428861_6bf4e2826f.jpg"/>

### Software
- [OpenMVH7Plus_MjpegStreaming.py](OpenMV/OpenMVH7Plus_MjpegStreaming.py)

### Hardware
- [OpenMV Cam H7 Plus](https://openmv.io/collections/cams/products/openmv-cam-h7-plus)
- [WiFi Shield](https://openmv.io/collections/shields/products/wifi-shield-1)

### Enclosure
- TODO

### Setup
- [OpenMV IDE](https://openmv.io/pages/download)

## Raspberry Pi Streaming Camera
This Raspberry Pi camera provides a basic video stream.

### Software
- [StreamEye](https://github.com/ccrisan/streameye)
- [FFmpeg](https://www.ffmpeg.org/)

### Hardware
- [Raspberry Pi 3B+](https://www.pi-shop.ch/raspberry-pi-3-model-b)
- [Raspberry Camera](https://www.pi-shop.ch/raspberry-pi-kamera-module-v2) or USB Camera

### Setup
- [StreamEye Setup](RaspberryPi/StreamEye/README.md)

## Raspberry Pi Streaming Camera with PoE
Same as [Raspberry Pi Streaming Camera](#raspberry-pi-streaming-camera), with additional power over Ethernet.

### Hardware
- [Raspberry Pi PoE Hat](https://www.raspberrypi.org/products/poe-hat/) (802.3af)

## Raspberry Pi Streaming Camera with Solar Power
Same as [Raspberry Pi Streaming Camera](#raspberry-pi-streaming-camera), with additional solar power.

Based on [this example](https://github.com/danjulio/MPPT-Solar-Charger/tree/master/examples/enclosure) by [@danjulio](https://github.com/danjulio), with local suppliers.

### Hardware
- [MPPT Solar Charger](https://www.tindie.com/products/globoy/mppt-solar-charger-for-intelligent-devices/)
- [12V 30W 36 Cell Solar Panel](https://www.conrad.ch/de/p/phaesun-sun-plus-30-s-monokristallines-solarmodul-30-w-12-v-2178372.html)
- [12V 9Ah Sealed Lead Battery](https://www.conrad.ch/de/p/conrad-energy-12-v-9-ah-250915-bleiakku-12-v-9-ah-blei-vlies-agm-b-x-h-x-t-151-x-94-x-65-mm-flachstecker-6-35-mm-war-250915.html)
- [12V Battery Charger](https://www.conrad.ch/de/p/h-tronic-bleiakku-ladegeraet-al600plus-2-v-6-v-12-v-ladestrom-max-0-6-a-512315.html) (optional)
- [Black 2.5mm Wire](https://www.conrad.ch/de/p/conrad-components-606284-fahrzeugleitung-flry-b-1-x-2-50-mm-schwarz-10-m-606284.html)
- [Red 2.5mm Wire](https://www.conrad.ch/de/p/conrad-components-606261-fahrzeugleitung-flry-b-1-x-2-50-mm-rot-10-m-606261.html)
- [Blue Connector](https://www.conrad.ch/de/p/vogt-verbindungstechnik-3905-flachsteckhuelse-steckbreite-4-8-mm-steckdicke-0-8-mm-180-teilisoliert-blau-1-st-736957.html)
- [Red Connector](https://www.conrad.ch/de/p/vogt-verbindungstechnik-3902-flachsteckhuelse-steckbreite-4-8-mm-steckdicke-0-8-mm-180-teilisoliert-rot-1-st-736933.html)

### Enclosure
- [IP67 Box with Clear Lid](https://www.mouser.ch/ProductDetail/Bud-Industries/PIP-11774-C/?qs=%2Fha2pyFaduhWtJcHf4Wic0ePltHJ10nv%252BRGIcnz2UHY8U4iCR362lHUokvZ%252BawDliJqYr5a2Kxo%3D)
- [Laser-cut Inlay](https://github.com/danjulio/MPPT-Solar-Charger/tree/master/examples/enclosure) by [@danjulio](https://github.com/danjulio)

## Raspberry Pi Streaming Endoscope
Same as [Streaming Raspberry Pi Camera](#streaming-raspberry-pi-camera), but with a USB endoscope.

<img src="https://live.staticflickr.com/65535/50979064987_da8b5c72d7.jpg"/>

### Hardware
- [USB endoscope](https://de.aliexpress.com/item/32954115464.html?spm=a2g0s.9042311.0.0.27424c4dtKIQ4i)

## Wi-Fi and PoE Access Point with 4G Uplink
This Wi-Fi and PoE Access Point with 4G uplink provides Internet-connectivity to Wi-Fi and PoE devices.

### Hardware
- [TP-Link Wi-Fi Router with 4G](https://www.digitec.ch/de/s1/product/tp-link-tl-mr6400-router-6078813)
- [TP-Link PoE Switch](https://www.digitec.ch/de/s1/product/tp-link-poe-switch-tl-sg105pe-5-port-5ports-switch-13966153)
- [0.5m RJ45 Cable](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-50cm-netzwerkkabel-5692267)
- [10m RJ45 Cable](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-1000cm-netzwerkkabel-5692274)
- [Multi-Plug](https://www.digitec.ch/de/s1/product/brennenstuhl-abzweigstecker-3-fach-sternfoermig-mehrfachstecker-3231053)
- [25m Pur-Pur Power Cord](https://www.jumbo.ch/de/apparatekabel-pur-pur-13185?sku=1194420)
- [T13 Power Coupling](https://www.jumbo.ch/de/gummikupplung-14466?sku=1251981)
- [T12 Power Plug](https://www.jumbo.ch/de/gummistecker-typ12-10a-250v-16168?sku=1251977)

### Enclosure
- [Barrel](https://www.jumbo.ch/de/weithalsfass-6280?sku=1097137)
- [Pole](https://www.jumbo.ch/de/rohrpfosten-verzinkt-5438?sku=1230258) (4cm)
- Inlays (TODO)
