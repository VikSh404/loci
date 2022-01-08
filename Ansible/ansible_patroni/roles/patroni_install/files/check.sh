#!/bin/bash
CONFIG_FILE=/etc/haproxy/haproxy.cfg
conf=/etc/keepalived/keepalived.conf
vip=$(expr "$(cat $conf)" : '.*\bvirtual_ipaddress\s*{\s*\(.*\)/*}')
vip=`expr "$vip" : '\([^ ]*\)' | sed 's/\./\\\\./g'`
if ip addr | grep -q "$vip"
then
echo Primary | systemd-cat -t keepalived_notify -p info
/usr/sbin/pidof haproxy || exit 100
echo Running HAProxy PIDs: `/usr/sbin/pidof haproxy` | systemd-cat -t keepalived_notify -p info
echo Server HAProxy works correctly. | systemd-cat -t keepalived_notify -p info
else
echo Secondary | systemd-cat -t keepalived_notify -p info
###systemctl status haproxy || exit 100
test -f ${CONFIG_FILE} || exit 100
echo HAProxy is installed and config file exists. Ready to become a Master | systemd-cat -t keepalived_notify -p info
fi
