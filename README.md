# Mitwelten.org IoT Hardware Proof of Concept

Work in progress.

## LoRaWAN Sensor Nodes
<img src="https://live.staticflickr.com/65535/50949785202_b05df960fc.jpg"/>

<img src="https://live.staticflickr.com/65535/50938710327_e62cc90963.jpg"/>

<img src="https://live.staticflickr.com/65535/50946175397_5f748fea67.jpg"/>

### Software
- [FeatherM4Express_TtnVBattDHT11.ino](Arduino/FeatherM4Express_TtnVBattDHT11/FeatherM4Express_TtnVBattDHT11.ino) or
- [FeatherM4Express_TtnVBattMoisture.ino](Arduino/FeatherM4Express_TtnVBattMoisture/FeatherM4Express_TtnVBattMoisture.ino)

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

## LoRaWAN Gateway with 3G Uplink
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

## AudioMoth Audio Logger
<img src="https://live.staticflickr.com/65535/50949169428_b02b0b8b92.jpg"/>

<img src="https://live.staticflickr.com/65535/50926837493_deef6a66f1.jpg"/>

### Hardware
- https://www.openacousticdevices.info/audiomoth
- 3 * AA Batteries
- Micro SD Card

### Enclosure
- [AudioMoth Vault](https://www.thingiverse.com/thing:4546491) by [@brandonh](https://www.thingiverse.com/brandonh), CC BY-NC-SA
- [Membrane](https://www.alibaba.com/product-detail/Customized-IP67-protective-vent-waterproof-acoustic_62076766363.html)
- [Magnets](https://www.supermagnete.ch/scheibenmagnete-neodym/scheibenmagnet-6mm-3mm_S-06-03-N)
- [Glue](https://www.supermagnete.ch/werkstatt-magnete/uhu-max-repair_WS-ADH-01)

### Setup
- [AudioMoth Desktop App](https://www.openacousticdevices.info/applications)
- [Sonic Visualiser](https://sonicvisualiser.org/download.html)

## Bug Tracking Camera
<img src="https://live.staticflickr.com/65535/50950426063_26e88a4d96.jpg"/>

### Software
- [OpenMVH7_BlobTracking.py](OpenMV/OpenMVH7_BlobTracking.py)

### Hardware
- [OpenMV Cam H7](https://openmv.io/collections/products/products/openmv-cam-h7)

### Enclosure
- TODO

### Setup
- [OpenMV IDE](https://openmv.io/pages/download)
