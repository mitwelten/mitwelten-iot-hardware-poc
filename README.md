# Mitwelten.org IoT Hardware Proof of Concept

Work in progress. Questions? Contact [mitwelten.technik@fhnw.ch](mailto:mitwelten.technik@fhnw.ch)

- [Audio Logger with Large Battery](#audio-logger-with-large-battery)
- [LiPo/Li-Ion Charging Station](#lipoli-ion-charging-station)
- [LiPo/Li-Ion Charger with Display](#lipoli-ion-charger-with-display)
- [LoRaWAN Gateway with 3G Uplink](#lorawan-gateway-with-3g-uplink)
- [LoRaWAN Env Sensor Node](#lorawan-env-sensor-node)
- [LoRaWAN Env Sensor Node with Solar Power](#lorawan-env-sensor-node-with-solar-power)
- [LoRaWAN Pax Sensor Node with Solar Power](#lorawan-pax-sensor-node-with-solar-power)
- [OpenMV Photo Logging Camera](#openmv-photo-logging-camera)
- [Raspberry Pi Streaming Camera with PoE](#raspberry-pi-streaming-camera-with-poe)
- [Raspberry Pi Zero Streaming Camera with PoE](#raspberry-pi-zero-streaming-camera-with-poe)
- [Raspberry Pi ArduCam Streaming Camera with PoE](#raspberry-pi-arducam-streaming-camera-with-poe)
- [Wi-Fi and PoE Access Point with 4G Uplink](#wi-fi-and-poe-access-point-with-4g-uplink)
- [PoE Access Point Port Upgrade](#poe-access-point-port-upgrade)
- [Color LED Pixel](#color-led-pixel)
- [Direction Indicator](#direction-indicator)
- [Bluetooth Speaker](#bluetooth-speaker)
- [Unfinished PoC](#unfinished-poc)
- [License](#license)

## LoRaWAN Env Sensor Node
This LoRaWAN environment sensor node can send small amounts (< 52 bytes) of data with a low frequency (1 per 15+ min) over long distances (1+ km).

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

## LoRaWAN Env Sensor Node with Solar Power
Same as [LoRaWAN Env Sensor Node](#lorawan-env-sensor-node), with additional solar power.

<img src="https://live.staticflickr.com/65535/51345501692_c15b172346.jpg"/>

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

## LoRaWAN Pax Sensor Node with Solar Power
Based on [LoRaWAN Env Sensor Node with Solar Power](#lorawan-env-sensor-node-with-solar-power), with more solar power.

<img src="https://live.staticflickr.com/65535/52725541713_38c395331f.jpg"/>

<img src="https://live.staticflickr.com/65535/52928472378_59d4da718c.jpg"/>

### Software
- [https://github.com/mitwelten/mitwelten-21hs-p7-esp32-lora-wifi-paxcounter](https://github.com/mitwelten/mitwelten-21hs-p7-esp32-lora-wifi-paxcounter)

### Hardware
- [Feather HUZZAH32 ESP32](https://www.adafruit.com/product/3591)
- [FeatherWing RFM95W](https://github.com/tamberg/fhnw-iot/wiki/FeatherWing-RFM95W)
- [Stacking Headers](https://www.adafruit.com/product/2830)
- [RFM95W Adapter](https://github.com/tamberg/fhnw-iot/tree/master/08/Fritzing)
- [Antenna Connector](https://www.adafruit.com/product/1865)
- [Mini Antenna](https://www.adafruit.com/product/1858)
- [Grove Adapter](https://github.com/tamberg/fhnw-iot-bricks/tree/master/Hardware/Adapter_M4_v0.2)
- [3000mAh Li-ion Battery](https://www.bastelgarage.ch/solar-lipo/li-ion-akku-3000ma-18650-mit-schutzelektronik-und-stecker)
- [6V, 2W Solar Panel](https://www.adafruit.com/product/200) (or [this](https://www.adafruit.com/product/5366) w/ [this](https://adafruit.com/products/2788))
- [USB, Solar, LiPo Charger](https://www.adafruit.com/product/4755)
- [JST 2-pin Jumper Cable](https://www.adafruit.com/product/4714)
- [3.5/1.1mm to 5.5/2.1mm Jack Adapter](https://www.adafruit.com/product/4287)
- [4700uF, 10v Electrolytic Capacitor](https://www.adafruit.com/product/1589) (optional)
- [10K Precision Epoxy Thermistor](https://www.adafruit.com/product/372)(optional)

### Enclosure
- [AP9 Junction Box](https://new.abb.com/products/2TKA140012G1/ap9-junction-box-ip65)
- Laser-cut [AP9 Adapter](https://github.com/mitwelten/mitwelten-iot-hardware-poc/tree/main/OpenScad/Pax_AP9Adapter)
- Laser-cut [AP9 Solar Fixture](https://github.com/mitwelten/mitwelten-iot-hardware-poc/tree/main/OpenScad/AP9_SolarFixture)

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

## Audio Logger with Large Battery
This audio logging microphone can record and store a broad range of frequencies, triggered by time of day or loudness.

<img src="https://live.staticflickr.com/65535/51145373400_7879ec11d9.jpg"/>

<img src="https://live.staticflickr.com/65535/51145373515_9d780563e6.jpg"/>

### Software
- https://www.openacousticdevices.info/mobileapplications
- https://github.com/mitwelten/mitwelten-audio-uploader

### Hardware
- https://www.openacousticdevices.info/audiomoth
- [Micro SD Card](https://www.digitec.ch/de/s1/product/sandisk-extreme-microsd-a2-inkl-sd-adapter-microsdxc-64gb-u3-uhs-i-speicherkarte-9706365) (ExFAT)
- [3.7V, 4400 mAh LiIon Battery](https://www.adafruit.com/product/354)
- [JST 2-Pin Header Cable M](https://www.adafruit.com/product/3814)
- [USB Li-Ion charger](https://www.adafruit.com/product/1304) (optional)

### Enclosure
- [AP9 Junction Box](https://new.abb.com/products/2TKA140012G1/ap9-junction-box-ip65)
- Laser-cut [AP9 Adapter](OpenScad/AudioMoth_AP9Adapter)
- [Membrane](https://www.alibaba.com/product-detail/Customized-IP67-protective-vent-waterproof-acoustic_62076766363.html)

## LiPo/Li-Ion Charging Station
This charging station allows to safely charge LiPo or Li-Ion batteries.

<img src="https://live.staticflickr.com/65535/51264412719_f9fc83c7d6.jpg"/>

## LiPo/Li-Ion Charger with Display
<img src="https://live.staticflickr.com/65535/51737262196_1ef97d272a.jpg"/>

<img src="https://live.staticflickr.com/65535/51741375698_6e51741369.jpg"/>

## Software
- [nRF52840_VBattLoggerOled.ino](Arduino/nRF52840_VBattLoggerOled/nRF52840_VBattLoggerOled.ino)

## Hardware
- https://www.adafruit.com/product/4062
- https://www.adafruit.com/product/4309
- https://www.seeedstudio.com/Grove-OLED-Display-0-66-SSD1306-v1-0-p-5096.html

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
- [AP9 Junction Box](https://new.abb.com/products/2TKA140012G1/ap9-junction-box-ip65)
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

## Raspberry Pi Streaming Camera with PoE
A Raspberry Pi-based streaming camera with power over Ethernet.

<img src="https://live.staticflickr.com/65535/51161321095_3d5992ed48.jpg"/>

<img src="https://live.staticflickr.com/65535/51222661454_4bfd413109.jpg"/>

<img src="https://live.staticflickr.com/65535/51342225992_ccdbe97d40.jpg"/>

### Hardware
- [Raspberry Pi 3 B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Camera](https://www.raspberrypi.org/products/camera-module-v2/) or USB Camera
- [Raspberry Pi PoE Hat](https://www.raspberrypi.org/products/poe-hat/) (802.3af)

### Enclosure
- [AP10 Junction Box](https://new.abb.com/products/2TKA140002G1/ap10-junction-box-ip65)
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
- [AP10 Junction Box](https://new.abb.com/products/2TKA140002G1/ap10-junction-box-ip65)
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
- [AP10 Junction Box](https://new.abb.com/products/2TKA140002G1/ap10-junction-box-ip65)
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
- 4 * [10m RJ45 Cable](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-1000cm-netzwerkkabel-5692274) (or [15m](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-1500cm-netzwerkkabel-5692275))
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
- 4 * [10m RJ45 Cable](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-1000cm-netzwerkkabel-5692274) (or [15m](https://www.digitec.ch/de/s1/product/lindy-netzwerkkabel-sftp-kat-6-1500cm-netzwerkkabel-5692275))

### Enclosure
- 3D-printed [Barrel Plug Port Upgrade](OpenScad/AccessPoint_Plug_Port_Upgrade)
- 3D-printed [AccessPoint Switch Fixture](OpenScad/AccessPoint_Fixture_Port_Upgrade)
- Laser-cut [Barrel Fixture Port Upgrade](OpenScad/AccessPoint_Fixture_Port_Upgrade)

## Color LED Pixel
<img src="https://live.staticflickr.com/65535/52846789322_25510d4b3e.jpg"/>

<img src="https://live.staticflickr.com/65535/52847365296_5c077737f7.jpg"/>

### Hardware
- [Feather HUZZAH32 ESP32](https://www.adafruit.com/product/3591)
- [Grove Adapter](https://www.seeedstudio.com/Grove-Shield-for-Particle-Mesh-p-4080.html)
- [Grove LED Ring](https://www.seeedstudio.com/Grove-RGB-LED-Ring-20-WS2813-Mini.html)
 
### Enclosure
- [AP9 Junction Box](https://new.abb.com/products/2TKA140012G1/ap9-junction-box-ip65)
- [AP9_Pixel_Cover](https://github.com/mitwelten/mitwelten-iot-hardware-poc/tree/main/OpenScad/AP9_Pixel_Cover)
- [AP9_Pixel_Fixture](https://github.com/mitwelten/mitwelten-iot-hardware-poc/tree/main/OpenScad/AP9_Pixel_Fixture)
- [AP9_Pixel_Tube](https://github.com/mitwelten/mitwelten-iot-hardware-poc/tree/main/OpenScad/AP9_Pixel_Tube)
- [Tombola Capsule](https://shop.tombotto.ch/produkt-kategorie/Tombola/Leerkapseln/) 5cm

## Direction Indicator
<img src="https://live.staticflickr.com/65535/51936432943_f15ca18707.jpg"/>
<img src="https://live.staticflickr.com/65535/51935374882_113c21700f.jpg"/>
<img src="https://live.staticflickr.com/65535/51937596536_6558b23d7d.jpg"/>

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
- [AP9 Junction Box](https://new.abb.com/products/2TKA140012G1/ap9-junction-box-ip65)
- [ZaunPixel](OpenScad/ZaunPixel)

## Bluetooth Speaker
<img src="https://live.staticflickr.com/65535/53037322902_6c5800eda9.jpg"/>

<img src="https://live.staticflickr.com/65535/53038086409_804e42065e.jpg"/>

### Hardware
- [Hama Pocket 3.0](https://www.digitec.ch/de/s1/product/hama-pocket-30-14-h-10-m-akkubetrieb-bluetooth-lautsprecher-23952994)

### Enclosure
- [AP10 Junction Box](https://new.abb.com/products/2TKA140002G1/ap10-junction-box-ip65)
- [Hama_AP10Adapter](https://github.com/mitwelten/mitwelten-iot-hardware-poc/tree/main/OpenScad/Hama_AP10Adapter)

## Unfinished PoC
Additional, unfinished or abandoned PoC.
- [Arduino-based](Arduino/README.md)
- [AudioMoth-based](AudioMoth/README.md)
- [OpenMV-based](OpenMV/README.md)
- [Raspberry Pi-based](RaspberryPi/README.md)

## License
Copyright (c) 2024 FHNW University of Applied Sciences and Arts Northwestern Switzerland
- Source code (.C, .PY, ...) is licensed under [MIT license](LICENSE), except where noted otherwise.
- Design files (.DXF, .SVG, .STL, ...) are licensed [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), except where noted otherwise.
- Documentation (.PDF, .TXT, .MD, ...) is licensed [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), except where noted otherwise.
