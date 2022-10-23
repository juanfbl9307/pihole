sudo docker-compose up -d
sudo chmod -R o+w /etc/systemd/system
sudo cat << EOF > /etc/systemd/system/pihole.service
[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=$(pwd)
ExecStart=$(which docker-compose) up -d
ExecStop=$(which docker-compose) down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF
sudo chmod -R o-w /etc/systemd/system
