# APGateway

## Setup

### Prepare SD Card

On the computer

- Install [Raspberry Pi Imager](https://www.raspberrypi.org/software/)
- Select _Raspberry Pi OS (other)_ > _Raspberry Pi OS Lite (32-bit)_
- Click _Choose SD Card_, then _Write_
- Remove, re-insert SD Card
- To enable SSH, type

    ```bash
    touch /Volumes/boot/ssh
    ```

### Prepare Raspberry Pi 4B

On the Pi

- Insert prepared SD Card
- Connect to power via USB-C
- Connect to Ethernet via RJ45
- Add Argon Poly+ case with fan

On the computer

- Share Computer Wi-Fi to Ethernet
- Log into Pi via SSH (pw: raspberry)

    ```bash
    ssh pi@raspberrypi.local
    ```

On the Pi

- Change the password

    ```bash
    passwd
    ```

- Note the MAC address

    ```bash
    ifconfig | grep ether
    ```

- Expand the filesystem

    ```bash
    sudo raspi-config # Advanced Options > Expand Filesystem
    ```

- Enable the fan
  - in `/boot/config.txt`, replace:

    ```ini
    [all]
    dtoverlay=vc4-fkms-v3d
    ```

  - by:

    ```ini
    [all]
    dtoverlay=gpio-fan,gpiopin=18,temp=55000
    ```

- Format and mount the hard disk (based on [this](https://www.raspberrypi.org/documentation/configuration/external-storage.md))

    ```bash
    sudo apt update
    sudo apt install -y btrfs-progs # for BTRFS
    sudo blkid # identify the device (i.e. /dev/sda)
    sudo mkfs.btrfs -L capture /dev/sda1 # matching the device identified in previous step
    echo '/dev/disk/by-label/capture /mnt/elements btrfs   defaults,auto,user    0 0' | sudo tee --append /etc/fstab
    sudo mount /mnt/elements
    sudo chown pi /mnt/elements
    ```

- Install nmap

    ```bash
    sudo apt-get install nmap
    ```

- Install capture.py & .service

    ```bash
    cd ~
    mkdir capture
    cd capture
    wget -O capture.py https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/APGateway/Capture/capture.py
    wget -O config.json https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/APGateway/Capture/config.json
    nano config.json # edit camera_ids
    sudo wget -O /etc/systemd/system/capture.service https://raw.githubusercontent.com/mitwelten/mitwelten-iot-hardware-poc/main/RaspberryPi/APGateway/Capture/capture.service
    sudo systemctl daemon-reload
    sudo systemctl enable capture.service
    sudo systemctl start capture.service
    ```

- [Install Yaler](https://yaler.net/raspberrypi) (or an [alternative](https://alternativeto.net/software/yaler/)) and enable [SSH access](https://yaler.net/raspberrypi#SSH)
- Install and set up image uploader and monitoring
  - Clone mitwelten-ml-backend repo, install dependencies, set credentials

    ```bash
    git clone https://github.com/mitwelten/mitwelten-ml-backend.git
    UPLOADERDIR="$HOME/mitwelten-ml-backend/ingest/uploader"
    cd $UPLOADERDIR
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -U pip
    pip install -r requirements-uploader-node.txt

    # (un)install prometheus and dependencies
    sudo apt update -y
    sudo apt install -y prometheus-node-exporter
    sudo systemctl stop exim4.service
    sudo systemctl disable exim4.service
    sudo systemctl stop smartd.service
    sudo systemctl disable smartd.service
    sudo systemctl stop prometheus-node-exporter-smartmon.timer
    sudo systemctl disable prometheus-node-exporter-smartmon.timer
    sudo systemctl stop prometheus-node-exporter-apt.timer
    sudo systemctl disable prometheus-node-exporter-apt.timer
    sudo systemctl stop prometheus-node-exporter-ipmitool-sensor.timer
    sudo systemctl disable prometheus-node-exporter-ipmitool-sensor.timer
    sudo systemctl stop prometheus-node-exporter-mellanox-hca-temp.timer
    sudo systemctl disable prometheus-node-exporter-mellanox-hca-temp.timer

    # copy credentials file
    cp ../../credentials_example.py credentials.py
    vi credentials.py
    ```

  - Edit `credentials.py` accordingly, with options set for `MinioConfig` and `RestApiConfig`.
  - Set up Prometheus Node Exporter

    ```bash
    mkdir $HOME/monitoring
    echo 'ARGS="--web.listen-address=\":9958\"
     --collector.textfile.directory=\"/home/pi/monitoring/\"
     --collector.filesystem.ignored-mount-points=\"^/(dev|proc|run|sys|media|var/lib/docker)($|/)\""' \
        | tr -d '\n' \
        | sudo tee --append /etc/default/prometheus-node-exporter
    ```

  - Enable remote access to monitoring endpoint

    ```bash
    RELAY_DOMAIN='RELAY_DOMAIN' # set accordingly
    echo "[Unit]
    Description=yalertunnel service on port 9958

    [Service]
    WorkingDirectory=/home/pi/yalertunnel
    ExecStart=/home/pi/yalertunnel/yalertunnel server 127.0.0.1:9958 tls:try.yaler.io:443 ${RELAY_DOMAIN}

    [Install]
    WantedBy=multi-user.target" \
        | sudo tee /etc/systemd/system/mitwelten-monitoring-tunnel.service
    ```

  - Install and start system units

    ```bash
    # enable lingering (start user units w/o login)
    sudo loginctl enable-linger $USER

    # install system units
    mkdir -p $HOME/.config/systemd/user
    ln -s $UPLOADERDIR/services/mitwelten-img-indexer.service $HOME/.config/systemd/user/
    ln -s $UPLOADERDIR/services/mitwelten-img-metadata.service $HOME/.config/systemd/user/
    ln -s $UPLOADERDIR/services/mitwelten-img-uploader.service $HOME/.config/systemd/user/
    ln -s $UPLOADERDIR/services/mitwelten-exporter.service $HOME/.config/systemd/user/

    # enable the units
    sudo systemctl enable mitwelten-monitoring-tunnel.service
    sudo systemctl enable prometheus-node-exporter.service
    systemctl --user daemon-reload
    systemctl --user enable mitwelten-img-indexer.service
    systemctl --user enable mitwelten-img-metadata.service
    systemctl --user enable mitwelten-img-uploader.service
    systemctl --user enable mitwelten-exporter.service

    # start the units
    sudo systemctl start mitwelten-monitoring-tunnel.service
    sudo systemctl start prometheus-node-exporter.service
    systemctl --user start mitwelten-img-indexer.service
    systemctl --user start mitwelten-img-metadata.service
    systemctl --user start mitwelten-img-uploader.service
    systemctl --user start mitwelten-exporter.service
    ```

- Make sure the daemons are up and running

    ```bash
    ps aux | grep [c]apture
    ps aux | grep [y]aler
    systemctl --no-pager status prometheus-node-exporter.service mitwelten-monitoring-tunnel.service && \
    systemctl --no-pager --user status mitwelten-img-indexer.service mitwelten-img-metadata.service mitwelten-img-uploader.service mitwelten-exporter.service
    ```

On monitoring host (prometheus):

- Add target to service-discovery (`monitoring/prometheus/sd/mitwelten_capture-nodes.json` in [mitwelten-db-backend](https://github.com/mitwelten/mitwelten-db-backend))

    ```json
    {
    "labels": {
        "job": "mitwelten",
        "type": "picam_ap",
        "description": "Location Description"
    },
    "targets": [
        "RELAY_DOMAIN.try.yaler.io"
    ]
    }
    ```
