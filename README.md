# Mitwelten.org IoT Hardware Proof of Concept

Work in progress. Questions? Contact [mitwelten.technik@fhnw.ch](mailto:mitwelten.technik@fhnw.ch)

- [AudioMoth Audio Logging Microphone](#audiomoth-audio-logging-microphone)
- [AudioMoth Audio Logging Microphone with LiPo Battery](#audiomoth-audio-logging-microphone-with-lipo-battery)
- [LiPo/Li-Ion Charging Station](#lipoli-ion-charging-station)
- [LoRaWAN Gateway with 3G Uplink](#lorawan-gateway-with-3g-uplink)
- [LoRaWAN Sensor Node](#lorawan-sensor-node)
- [LoRaWAN Sensor Node with Solar Power](#lorawan-sensor-node-with-solar-power)
- [OpenMV Bug Tracking Camera](#openmv-bug-tracking-camera)
- [OpenMV Photo Logging Camera](#openmv-photo-logging-camera)
- [OpenMV Photo Logging Camera with PIR](#openmv-photo-logging-camera-with-pir)
- [OpenMV Video Streaming Camera](#openmv-video-streaming-camera)
- [Raspberry Pi Streaming Camera](#raspberry-pi-streaming-camera)
- [Raspberry Pi Streaming Camera with PoE](#raspberry-pi-streaming-camera-with-poe)
- [Raspberry Pi Zero Streaming Camera with PoE](#raspberry-pi-zero-streaming-camera-with-poe)
- [Raspberry Pi ArduCam Streaming Camera with PoE](#raspberry-pi-arducam-streaming-camera-with-poe)
- [Raspberry Pi Streaming Camera with Solar Power](#raspberry-pi-streaming-camera-with-solar-power)
- [Raspberry Pi Streaming Endoscope](#raspberry-pi-streaming-endoscope)
- [Wi-Fi and PoE Access Point with 4G Uplink](#wi-fi-and-poe-access-point-with-4g-uplink)
- [PoE Access Point Port Upgrade](#poe-access-point-port-upgrade)
- [ZaunPixel Actuator](#zaunpixel-actuator)

## LoRaWAN Sensor Node
This LoRaWAN sensor node can send small amounts (< 52 bytes) of data with a low frequency (1 per 15+ min) over long distances (1+ km).

<img src="https://live.staticflickr.com/65535/50949785202_b05df960fc.jpg"/>

<img src="https://live.staticflickr.com/65535/50938710327_e62cc90963.jpg"/>

<img src="https://live.staticflickr.com/65535/50946175397_5f748fea67.jpg"/>

### Software
- [FeatherM4Express_TtnVBattDHT11.ino](Arduino/FeatherM4Express_TtnVBattDHT11/FeatherM4Express_TtnVBattDHT11.ino)
- [FeatherM4Express_TtnVBattMoisture.ino](Arduino/FeatherM4Express_TtnVBattMoisture/FeatherM4Express_TtnVBattMoisture.ino)

### Hardware
- [Feather M4 Express](https://github.com/tamberg/fhnw-iot/wiki/Feather-M4-Express)
- [FeatherWing RFM95W](https://github.com/tamberg/fhnw-iot/wiki/FeatherWing-RFM95W)
- [Grove Adapter](https://github.com/tamberg/fhnw-iot/wiki/Grove-Adapters#grove-shield-for-feather)
- [DHT11](https://www.seeedstudio.com/Grove-Temperature-Humidity-Sensor-DHT11.html) or [Soil Moisture](https://www.seeedstudio.com/Grove-Capacitive-Moisture-Sensor-Corrosion-Resistant.html) or other [Grove Sensors](https://github.com/tamberg/fhnw-iot/wiki/Various#sensors)
- [3.7V, 2000 mAh LiPo Battery](https://de.aliexpress.com/wholesale?catId=0&initiative_id=SB_20191122074854&origin=y&SearchText=103450) (JST 2, check polarity, e.g. [these](https://de.aliexpress.com/item/4001270935242.html))

### Enclosure
- [AP9 Junction Box](https://new.abb.com/products/2TKA140012G1/ap9-junction-box-ip65)
- [AP9 Template](https://www.thingiverse.com/thing:3638252) and [Remixes](https://www.thingiverse.com/thing:3638252/remixes) by [@tamberg](https://www.thingiverse.com/tamberg/designs), CC BY-SA
- [AP9 PVCTubeFixture](OpenScad/AP9_PVCTubeFixture)
- [PVC Tube](https://www.bauundhobby.ch/maschinen-werkstatt/elektro-material/verlegware/rohre/rohr-kir-m20-grau-2-m/p/4002432)

### Setup
- [Arduino IDE](https://www.arduino.cc/en/software)
- [TTN Console](https://console.thethingsnetwork.org/)
- [ThingSpeak](https://thingspeak.com/)

### Data
- https://mitwelten.org/id/0000-0001

## LoRaWAN Sensor Node with Solar Power
Same as [LoRaWAN Sensor Node](#lorawan-sensor-node), with additional solar power.

<img src="https://live.staticflickr.com/65535/50975641601_07fd28bbbd.jpg"/>

<img src="https://live.staticflickr.com/65535/50975754157_050c9cbf8d.jpg"/>

### Hardware
- [6V, 1W Solar Panel](https://www.adafruit.com/product/3809)
- [USB, Solar, LiPo Charger](https://www.adafruit.com/product/4755)
- [JST 2-pin Jumper Cable](https://www.adafruit.com/product/4714)
- [3.5/1.1mm to 5.5/2.1mm Jack Adapter](https://www.adafruit.com/product/4287)
- [4700uF, 10v Electrolytic Capacitor](https://www.adafruit.com/product/1589) (optional)
- [10K Precision Epoxy Thermistor](https://www.adafruit.com/product/372)(optional)

### Enclosure
- [Solar PVC Tube fixture](OpenScad/Solar_PVCTubeFixture)
- [Solar Hinge fixture](OpenScad/Solar_PVCTubeFixture)

## LoRaWAN PAX Sensor Node with Solar Power
Based on [LoRaWAN Sensor Node with Solar Power](#lorawan-sensor-node-with-solar-power), with more solar power.

<img src="https://live.staticflickr.com/65535/52725541713_38c395331f.jpg"/>

### Hardware
- [6V, 2W Solar Panel](https://www.adafruit.com/product/200)
- [USB, Solar, LiPo Charger](https://www.adafruit.com/product/4755)
- [JST 2-pin Jumper Cable](https://www.adafruit.com/product/4714)
- [3.5/1.1mm to 5.5/2.1mm Jack Adapter](https://www.adafruit.com/product/4287)
- [4700uF, 10v Electrolytic Capacitor](https://www.adafruit.com/product/1589) (optional)
- [10K Precision Epoxy Thermistor](https://www.adafruit.com/product/372)(optional)

### Enclosure
- TODO

## LoRaWAN Gateway with 3G Uplink
This LoRaWAN gateway provides Internet-connectivity to LoRaWAN sensor nodes over a long range (1+ km).

<img src="https://live.staticflickr.com/65535/50949786697_853167d179.jpg"/>

### Hardware
- [Geneko GWR352-EM770W 3G Router](https://www.geneko.rs/en/products/m2m-products-and-solutions/gwr-cellular-router-series/gwr352-3g-router)
- [IMST iC880a SPI LoRaWAN Concentrator](https://shop.imst.de/wireless-modules/lora-products/8/ic880a-spi-lorawan-concentrator-868-mhz)
- [Raspberry Pi 3 B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
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
- [Micro SD Card](https://www.digitec.ch/de/s1/product/sandisk-extreme-microsd-a2-inkl-sd-adapter-microsdxc-64gb-u3-uhs-i-speicherkarte-9706365) (ExFAT)

### Enclosure
- [AudioMoth Vault](https://www.thingiverse.com/thing:4546491) by [@brandonh](https://www.thingiverse.com/brandonh), CC BY-NC-SA
- [Membrane](https://www.alibaba.com/product-detail/Customized-IP67-protective-vent-waterproof-acoustic_62076766363.html)
- [Magnets](https://www.supermagnete.ch/scheibenmagnete-neodym/scheibenmagnet-6mm-3mm_S-06-03-N)
- [Glue](https://www.supermagnete.ch/werkstatt-magnete/uhu-max-repair_WS-ADH-01)

### Setup
- [AudioMoth Desktop App](https://www.openacousticdevices.info/applications)
- [AudioMoth LED Guide](https://www.openacousticdevices.info/led-guide)
- [Sonic Visualiser](https://sonicvisualiser.org/download.html)

## AudioMoth Audio Logging Microphone with LiPo Battery
Like [AudioMoth Audio Logging Microphone](#audiomoth-audio-logging-microphone), but with LiPo Battrey.

<img src="https://live.staticflickr.com/65535/51145373400_7879ec11d9.jpg"/>

### Enclosure
- [AP9 Junction Box](https://new.abb.com/products/2TKA140012G1/ap9-junction-box-ip65)
- Laser-cut [AP9 Adapter](OpenScad/AudioMoth_AP9Adapter)
- [Membrane](https://www.alibaba.com/product-detail/Customized-IP67-protective-vent-waterproof-acoustic_62076766363.html)
- [3.7V, 4400 mAh LiIon Battery](https://www.adafruit.com/product/354)
- [JST 2-Pin Header Cable M](https://www.adafruit.com/product/3814)
- [USB Li-Ion charger](https://www.adafruit.com/product/1304) (optional)

## LiPo/Li-Ion Charging Station
This charging station allows to safely charge LiPo or Li-Ion batteries.

<img src="https://live.staticflickr.com/65535/51264412719_f9fc83c7d6.jpg"/>

## OpenMV Photo Logging Camera
This photo logging camera allows to continuously take snapshots in an outdoor setting.

<img src="https://live.staticflickr.com/65535/51893228830_758510dd83.jpg"/>

### Software
- [OpenMVH7_PhotoLogging.py](OpenMV/OpenMVH7_PhotoLogging.py)
- [OpenMVH7Plus_PhotoLogging.py](OpenMV/OpenMVH7Plus_PhotoLogging.py) (Deep Sleep, 51mA avg.)

### Hardware
- [OpenMV Cam H7](https://openmv.io/collections/products/products/openmv-cam-h7)
- [3.7V, 6600 mAh LiIon Battery](https://www.adafruit.com/product/353) (JST 2, check polarity)
- Micro SD Card (ExFAT, Master Boot Record)

### Enclosure
- 3D printed [AP9 Adapter](OpenScad/OpenMVH7_AP9Adapter)
- 3D printed [AP9 Hinge Fixture](OpenScad/AP9_HingeFixture) (optional)
- 3D printed [PVCTubeFixture](OpenScad/Solar_PVCTubeFixture) (optional)
- 1 M4 x 40mm screw w/ locking nut

### Setup
- [OpenMV IDE](https://openmv.io/pages/download)

### Deploy
- Set RTC time t0 in the source code
- Save code to SD card as main.py
- Connect LiPo battery at t0

## OpenMV Photo Logging Camera with PIR
This photo logging camera allows to take snapshots in an outdoor setting when something moves.

<img src="https://live.staticflickr.com/65535/51059049837_77f5a53bda.jpg"/>

### Software
- [OpenMVH7Plus_PirWakeUpPhotoLogging.py](OpenMV/OpenMVH7Plus_PirWakeUpPhotoLogging.py)

### Hardware
- [OpenMV Cam H7 Plus](https://openmv.io/collections/products/products/openmv-cam-h7-plus)
- [Proto Shield](https://openmv.io/collections/shields/products/proto-shield)
- [PIR Motion Sensor](https://www.adafruit.com/product/189)
- [3.7V, 6600 mAh LiIon Battery](https://www.adafruit.com/product/353) (JST 2, check polarity)
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
- [Raspberry Pi 3 B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Camera](https://www.raspberrypi.org/products/camera-module-v2/)

### Setup
- [StreamEye Setup](RaspberryPi/StreamEye/README.md)

## Raspberry Pi Streaming Camera with PoE
Derived from [Raspberry Pi Streaming Camera](#raspberry-pi-streaming-camera), with additional power over Ethernet.

<img src="https://live.staticflickr.com/65535/51161321095_3d5992ed48.jpg"/>

<img src="https://live.staticflickr.com/65535/51222661454_4bfd413109.jpg"/>

<img src="https://live.staticflickr.com/65535/51342225992_ccdbe97d40.jpg"/>

### Hardware
- [Raspberry Pi 3 B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Camera](https://www.raspberrypi.org/products/camera-module-v2/) or USB Camera
- [Raspberry Pi PoE Hat](https://www.raspberrypi.org/products/poe-hat/) (802.3af)

### Enclosure
- [AP10 Adapter](OpenScad/PoePiCam_AP10Adapter)
- [AP10 Hinge Fixture](OpenScad/AP10_HingeFixture)
- [Pot Fixture](OpenScad/PoePiCam_PotFixture)
- [Alu Tube](https://www.elektrobedarf.ch/aluminiumrohr-m20-b%2071.20)
- [Gore Vent](https://www.distrelec.ch/de/druckausgleichsstopfen-m12-12-2mm-ip69k-polyamid-schwarz-gore-associates-gmbh-pmf-100585/p/30082596)
- M4 * 25mm Screw
- M4 Locking Nut

### Setup
- [PoEPiCam Setup](RaspberryPi/PoEPiCam)

## Raspberry Pi Zero Streaming Camera with PoE
Derived from [Raspberry Pi Streaming Camera with PoE](#raspberry-pi-streaming-camera-with-poe), based on a Pi Zero W with Wi-Fi.

<img src="https://live.staticflickr.com/65535/52321569953_042afc24ef.jpg"/>

<img src="https://live.staticflickr.com/65535/52321682179_f4437c3679.jpg"/>

<img src="https://live.staticflickr.com/65535/52321570893_41ac4244c8.jpg"/>

### Hardware
- [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)
- [Raspberry Camera](https://www.raspberrypi.org/products/camera-module-v2/)
- [Pi Zero Camera Cable](https://www.pi-shop.ch/raspberry-pi-zero-kamera-kabel)
- [PoE Splitter](https://www.pi-shop.ch/uctronics-poe-splitter-gigabit-5v-micro-usb-power-and-ethernet-to-raspberry-pi-3b) (802.3af)

### Enclosure
- [AP10 Adapter](OpenScad/PoEPiZeroCam_AP10Adapter)
- [AP10 Hinge Fixture v2](OpenScad/AP10_HingeFixture/AP10_HingeFixture2.stl)
- [Pot Fixture](OpenScad/PoePiCam_PotFixture)
- [Alu Tube](https://www.elektrobedarf.ch/aluminiumrohr-m20-b%2071.20)
- [Gore Vent](https://www.distrelec.ch/de/druckausgleichsstopfen-m12-12-2mm-ip69k-polyamid-schwarz-gore-associates-gmbh-pmf-100585/p/30082596)
- 3 * [10mm Spacers](https://www.conrad.ch/de/p/526363-abstandsbolzen-x-l-7-mm-x-10-mm-polystyrol-1-st-526363.html)
- 3 * [M2.5 * 16mm Screws](https://www.conrad.ch/de/p/toolcraft-to-5371935-zylinderschrauben-m2-5-16-mm-innensechskant-iso-4762-edelstahl-a2-100-st-1790645.html)
- 4 * [M2 * 3mm Screws](https://www.conrad.ch/de/p/toolcraft-1061796-zylinderschrauben-m2-3-mm-innensechskant-din-912-edelstahl-a2-100-st-1061796.html)
- M4 * 40mm Screw
- M4 Locking Nut

### Setup
- [PoEPiCam Setup](RaspberryPi/PoEPiCam) (Pi Cam) or
- [PoePiZeroArducam](RaspberryPi/PoePiZeroArducam) (ArduCam 16MP)

## Raspberry Pi ArduCam Streaming Camera with PoE
Derived from [Raspberry Pi Streaming Camera with PoE](#raspberry-pi-streaming-camera-with-poe) and [Raspberry Pi Zero Streaming Camera with PoE](#raspberry-pi-zero-streaming-camera-with-poe).

<img src="https://live.staticflickr.com/65535/52679079723_f55189d6db.jpg"/>

<img src="https://live.staticflickr.com/65535/52678869339_024d2578ef.jpg"/>

### Hardware
- [Raspberry Pi 3 B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Pi Cam 3](https://www.raspberrypi.com/products/camera-module-3/) or this [ArduCam](https://www.arducam.com/16mp-autofocus-camera-for-raspberry-pi/)
- [Raspberry Pi PoE Hat](https://www.raspberrypi.org/products/poe-hat/) (802.3af)

### Enclosure
- [AP10 Adapter](OpenScad/PoEPiArduCam_AP10Adapter)
- [AP10 Hinge Fixture v2](OpenScad/AP10_HingeFixture/AP10_HingeFixture2.stl)
- [RJ45 Wire Gland Tube](OpenScad/RJ45_WireGland_Tube) (TPU)
- [RJ45 Wire Gland Plug](OpenScad/RJ45_WireGland_Plug)
- [Pot Fixture](OpenScad/PoePiCam_PotFixture)
- [Alu Tube](https://www.elektrobedarf.ch/aluminiumrohr-m20-b%2071.20)
- [Gore Vent](https://www.distrelec.ch/de/druckausgleichsstopfen-m12-12-2mm-ip69k-polyamid-schwarz-gore-associates-gmbh-pmf-100585/p/30082596)
- 4 * [M2.5 * 16mm Screws](https://www.conrad.ch/de/p/toolcraft-to-5371935-zylinderschrauben-m2-5-16-mm-innensechskant-iso-4762-edelstahl-a2-100-st-1790645.html)
- 2 * [M2 * 3mm Screws](https://www.conrad.ch/de/p/toolcraft-1061796-zylinderschrauben-m2-3-mm-innensechskant-din-912-edelstahl-a2-100-st-1061796.html)
- M4 * 40mm Screw
- M4 Locking Nut

### Setup
- TODO

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
Same as [Streaming Raspberry Pi Camera](#streaming-raspberry-pi-camera), but with a USB endoscope.

<img src="https://live.staticflickr.com/65535/50979064987_da8b5c72d7.jpg"/>

### Hardware
- [USB endoscope](https://de.aliexpress.com/item/32954115464.html?spm=a2g0s.9042311.0.0.27424c4dtKIQ4i)

## Wi-Fi and PoE Access Point with 4G Uplink
This Wi-Fi and PoE Access Point with 4G uplink provides Internet-connectivity to Wi-Fi and PoE devices.

<img src="https://live.staticflickr.com/65535/51162813404_506099360e.jpg"/>

### Hardware
- [TP-Link TL-MR6400 4G Router](https://www.digitec.ch/de/s1/product/tp-link-tl-mr6400-router-6078813) (< 50 Mbit/s Upload)
- [TP-Link TL-SG105PE PoE Switch](https://www.digitec.ch/de/s1/product/tp-link-poe-switch-tl-sg105pe-5-port-5ports-switch-13966153) (4 * 802.3af)
- [Raspberry Pi 4B, 2GB RAM](https://www.pi-shop.ch/raspberry-pi-4-model-b-2gb)
- [Poly Case with Fan](https://www.pi-shop.ch/poly-case-for-rpi-4-with-dedicated-mini-cooling-fan)
- [SD Card, 128 GB](https://www.pi-shop.ch/kingston-microsdxc-karte-canvas-select-plus-128-gb)
- [Disk, 2TB](https://www.digitec.ch/de/s1/product/wd-elements-2tb-externe-festplatte-448766)
- [USB C Power Supply](https://www.pi-shop.ch/raspberry-pi-15w-power-supply-eu-schwarz)
- [Outlet Power Adapter](https://www.digitec.ch/de/s1/product/steffen-abzweigstecker-3xt13-ks-schwarz-mehrfachstecker-6153542)
- 2 * [0.5m RJ45 Cable](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-50cm-netzwerkkabel-5692267)
- 4 * [10m RJ45 Cable](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-1000cm-netzwerkkabel-5692274) (or [15m](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-1500cm-netzwerkkabel-5692275) or [20m](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-2000cm-netzwerkkabel-5692276) or [30m](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-3000cm-netzwerkkabel-5692277))
- [25m PUR-PUR Power Cord](https://www.jumbo.ch/de/apparatekabel-pur-pur-13185?sku=1194420) (or [50m](https://shop.meyerhwz.ch/?srv=search&pg=det&partnerId=9&rub=100044242&groupId=&artNr=100003741&markId=) or [100m](http://pur-kabel.ch/))
- [T13 Power Coupling](https://www.jumbo.ch/de/gummikupplung-14466?sku=1251981)
- [T12 Power Plug](https://www.jumbo.ch/de/gummistecker-typ12-10a-250v-16168?sku=1251977)
- SIM Card

### Enclosure
- [30L, 53cm, 32cm Barrel](https://www.jumbo.ch/de/weithalsfass-6280?sku=1097137)
- [8mm, 600mm, 600mm Plywood](https://www.jumbo.ch/de/sperrholz-pappel-12200?sku=1310591) (or 2 * [4mm](https://www.jumbo.ch/de/sperrholz-pappel-12200?sku=1310584))
- 3D-printed [Barrel Plug](OpenScad/AccessPoint_Plug)
- Laser-cut [Barrel Fixture](OpenScad/AccessPoint_Fixture)
- [Gore Membrane](https://www.distrelec.ch/de/druckausgleichsstopfen-m12-12-2mm-ip69k-polyamid-schwarz-gore-associates-gmbh-pmf-100585/p/30082596)
- [Gore Nut](https://www.distrelec.ch/de/gegenmutter-m12x1-m12-grau-gore-associates-gmbh-m10510-009/p/30155048)
- [Camouflage](https://www.hornbach.ch/shop/Tarnnetz-gruen-200x300-cm/10174067/artikel.html) (optional, or [this](https://www.jumbo.ch/de/tarnnetz-camouflage-26397?sku=1359450))
- [Sun Protection](https://www.jumbo.ch/de/rettungsdecke-160x210cm-4633?sku=1074645) (optional)
- 4 * 30 mm Wood Screws

### Stand
- [150cm, 4cm diameter Pole](https://www.jumbo.ch/de/rohrpfosten-verzinkt-5438?sku=1230258)
- [200cm, 50cm, 2.7cm Board](https://www.jumbo.ch/de/schalungstafel-5634?sku=1333377)
- CNC-cut [Barrel Pole Stand](OpenScad/AccessPoint_PoleStand)

### Setup
- [APGateway Setup](RaspberryPi/APGateway/README.md)
- [TPLink MR6400 Setup](TPLink/MR6400/README.md)

## PoE Access Point Port Upgrade
Adds 4 extra PoE ports to an existing [Wi-Fi and PoE Access Point](wi-fi-and-poe-access-point-with-4g-uplink).

### Hardware
- [TP-Link TL-SG105PE PoE Switch](https://www.digitec.ch/de/s1/product/tp-link-poe-switch-tl-sg105pe-5-port-5ports-switch-13966153) (4 * 802.3af)
- [Outlet Power Adapter](https://www.digitec.ch/de/s1/product/steffen-abzweigstecker-3xt13-ks-schwarz-mehrfachstecker-6153542)
- [0.5m RJ45 Cable](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-50cm-netzwerkkabel-5692267)

### Enclosure
- 3D-printed [Barrel Plug Port Upgrade](OpenScad/AccessPoint_Plug_Port_Upgrade)
- 3D-printed [AccessPoint Switch Fixture](OpenScad/AccessPoint_Fixture_Port_Upgrade)
- Laser-cut [Barrel Fixture Port Upgrade](OpenScad/AccessPoint_Fixture_Port_Upgrade)

## ZaunPixel Actuator
<img src="https://live.staticflickr.com/65535/51931885094_091e2b1777.jpg"/>

### Software
- Arduino IDE > Examples > Servo > swipe (e.g. on M4 pin 9)

### Hardware
- [Feather M4 Express](https://www.adafruit.com/product/3857) or any other Feather board with PWM
- [Feather Grove Adapter](https://www.adafruit.com/product/4309) (optional)
- [3.7V Li-Ion Battery](https://www.adafruit.com/product/1781)
- [AP3602A](https://www.adafruit.com/product/3661) (or [TPS61023](https://www.adafruit.com/product/4654)) 5V charge pump
- [74AHCT125](https://www.adafruit.com/product/1787) 3V to 5V level shifter
- Jumper wires M-M
- Mini Breadboard
- Servo

### Enclosure
- [ZaunPixel](OpenScad/ZaunPixel)
