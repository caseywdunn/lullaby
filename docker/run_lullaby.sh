#!/bin/bash
python3 /bin/prometheus_lullaby_client.py &
# drop slack secrets into alertmanager file
sed -i 's@WEBHOOK_URL@'\'"$WEBHOOK_URL"\''@' /etc/prometheus/alertmanager.yml
/bin/alertmanager --config.file=/etc/prometheus/alertmanager.yml &
/bin/prometheus --config.file=/etc/prometheus/prometheus.yml \
                --web.console.libraries=/etc/prometheus/console_libraries \
                --web.console.templates=/etc/prometheus/consoles \
                --storage.tsdb.retention=60d
