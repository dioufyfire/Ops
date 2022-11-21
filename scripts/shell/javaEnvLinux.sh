#!/bin/bash
set -x
echo "user "$1
adduser --system --disabled-login --group --no-create-home --home /data --shell /bin/false $1
DIR_DATA="/data/"
DIR_LOGS="/data/logs"
DIR_SCRIPTS="/data/scripts"
DIR_BACKUP="/data/backup"
DIR_WARS="/data/wars"

if [ ! -d "$DIR_DATA" ]
then
    mkdir /data
    chown $1:$1 /data
    chmod 774 /data
    echo "Creation dossier /data"
else
     chown $1:$1 /data
     chmod 774 /data
     echo "Modif dossier /data"
fi
##########
if [ ! -d "$DIR_LOGS" ]
then
    mkdir /data/logs
    chown $1:$1 /data/logs
    chmod 774 /data/logs
    echo "Creation dossier /data/logs"
else
     chown $1:$1 /data/logs
     chmod 774 /data/logs
     echo "Modif /data/logs"
fi
#########
if [ ! -d "$DIR_SCRIPTS" ]
then
    mkdir /data/scripts
    chown $1:$1 /data/scripts
    chmod 774 /data/scripts
    echo "Creation dossier /data/scripts"
else
     chown $1:$1 /data/scripts
     chmod 774 /data/scripts
     echo "Modif dossier /data/scripts"
fi

#########

# printf "\n########################\n%%radar ALL=(ALL) NOPASSWD: ALL\n#########################\n" >> /etc/sudoers
touch /etc/systemd/system/multi-user.target.wants/tcontrol.service
chmod 755 /etc/systemd/system/multi-user.target.wants/tcontrol.service
cat > /etc/systemd/system/multi-user.target.wants/tcontrol.service   <<EOF
[Unit]
Description=Service Tcontrol

[Service]
Type = idle
User=tcontrol
Group=tcontrol
#PIDFile=/data/pid/fraudefrontproxybigdata.pid
ExecStart =/usr/bin/sh -c 'exec java -jar \
-Xms5G -Xmx25G \
/data/wars/tcontrol*.war --no-liquibase --spring.profiles.active=pprod,no-liquibase \
--spring.config.location=file:/data/conf/ >> /data/logs/tcontrol.log'
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=tcontrol

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
#systemctl enable fraudefrontproxybigdata.service

touch /etc/logrotate.d/tcontrol.conf
chmod 0644 /etc/logrotate.d/tcontrol.conf
cat > /etc/logrotate.d/tcontrol.conf <<EOF

/data/logs/tcontrol.log {
    rotate 31
    daily
    create
    su tcontrol tcontrol
    missingok
    delaycompress
    dateext
    dateformat -%d%m%Y
    compress
    postrotate
        /bin/systemctl restart tcontrol.service  > /dev/null 2>/dev/null || true
    endscript
}
EOF
service rsyslog restart
logrotate -v /etc/logrotate.d/tcontrol.conf

set +x
