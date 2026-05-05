#!/bin/bash

exec > /var/log/user-data.log 2>&1
set -e

############################################
# Install dependencies
############################################

apt-get update -y
apt-get install -y wget tar adduser libfontconfig1 musl

############################################
# Create service users
############################################

id prometheus || useradd --no-create-home --shell /bin/false prometheus
id node_exporter || useradd --no-create-home --shell /bin/false node_exporter

############################################
# Install Node Exporter
############################################

cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.0/node_exporter-1.8.0.linux-amd64.tar.gz
tar xvf node_exporter-*.tar.gz

cp node_exporter-*/node_exporter /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter

cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

Restart=always

[Install]
WantedBy=multi-user.target
EOF

############################################
# Install Prometheus
############################################

cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
tar xvf prometheus-*.tar.gz

mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus

cp prometheus-*/prometheus /usr/local/bin/
cp prometheus-*/promtool /usr/local/bin/

############################################
# Create Prometheus config WITH node_exporter
############################################

cat <<EOF > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets:
          - localhost:9090

  - job_name: "node_exporter"
    static_configs:
      - targets:
          - localhost:9100
EOF

############################################
# Fix permissions
############################################

chown -R prometheus:prometheus /etc/prometheus
chown -R prometheus:prometheus /var/lib/prometheus
chmod -R 755 /var/lib/prometheus

############################################
# Create Prometheus service
############################################

cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Monitoring
After=network.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/prometheus \
--config.file=/etc/prometheus/prometheus.yml \
--storage.tsdb.path=/var/lib/prometheus

Restart=always

[Install]
WantedBy=multi-user.target
EOF

############################################
# Install Grafana
############################################

cd /tmp
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.4.1_amd64.deb
dpkg -i grafana-enterprise_10.4.1_amd64.deb || apt-get install -f -y

############################################
# Start all services
############################################

systemctl daemon-reexec
systemctl daemon-reload

systemctl enable node_exporter
systemctl enable prometheus
systemctl enable grafana-server

systemctl start node_exporter
systemctl start prometheus
systemctl start grafana-server


############################################
# Install Alert Testing Tools
############################################

apt-get install -y stress apache2

systemctl enable apache2
systemctl start apache2

############################################
# Create Dummy CPU Load Service (Optional)
############################################

cat <<EOF > /etc/systemd/system/dummy-load.service
[Unit]
Description=Dummy CPU Load Generator
After=network.target

[Service]
ExecStart=/usr/bin/stress --cpu 1
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable dummy-load.service