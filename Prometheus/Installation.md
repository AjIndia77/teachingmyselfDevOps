# Installation of Prometheus
First, create a dedicated Linux user for Prometheus and download Prometheus:
```sh
sudo useradd --system --no-create-home --shell /bin/false Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.47.1/prometheus-2.47.1.linux-amd64.tar.gz

```
Extract Prometheus files, move them, and create directories:
```sh
tar -xvf prometheus-2.47.1.linux-amd64.tar.gz
cd prometheus-2.47.1.linux-amd64/
sudo mkdir -p /data /etc/prometheus
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
```
Set ownership for directories:
```sh
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/
```
Create a systemd unit configuration file for Prometheus:
```sh
sudo vim /etc/systemd/system/prometheus.service
```
Add the following content to the prometheus.service file:
```sh
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
```
<p>Here's a brief explanation of the key parts in this prometheus.service file:

User and Group specify the Linux user and group under which Prometheus will run.

ExecStart is where you specify the Prometheus binary path, the location of the configuration file (prometheus.yml), the storage directory, and other settings.

web.listen-address configures Prometheus to listen on all network interfaces on port 9090.

web.enable-lifecycle allows for management of Prometheus through API calls.
</p>

Enable and start Prometheus:
```sh
sudo systemctl enable prometheus
sudo systemctl start prometheus
```
Verify Prometheus's status:
```sh

sudo systemctl status prometheus
```
You can access Prometheus in a web browser using your server's IP and port 9090:
```sh
http://<your-public-ip>:9090
```
