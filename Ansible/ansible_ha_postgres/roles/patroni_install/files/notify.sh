#!/bin/bash
TYPE=$1
NAME=$2
STATE=$3

echo "Script running with parameters $1 $2 $3" | systemd-cat -t keepalived_notify -p info

case $STATE in
        "MASTER") systemctl start haproxy
                  echo "Running MASTER mode" | systemd-cat -t keepalived_notify -p info
                  exit 0
                  ;;
        "BACKUP")
                  systemctl stop haproxy
                  echo "Running BACKUP mode" | systemd-cat -t keepalived_notify -p info
				  exit 0
                  ;;
        "FAULT")  systemctl stop haproxy
                  echo "FAULT" | systemd-cat -t keepalived_notify -p info
                  exit 0
                  ;;
        *)        echo "unknown state" | systemd-cat -t keepalived_notify -p info
                  exit 1
                  ;;
esac
