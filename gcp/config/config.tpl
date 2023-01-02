#!/bin/bash

set -x # Debug
set -e # Strict exit codes

echo "Applying system patches"
apt-get update
sudo apt-get upgrade -y
ufw disable

echo "disabling iptables manual configuration"
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections

echo "Installing Ops Agent"
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
bash add-google-cloud-ops-agent-repo.sh --also-install

echo "installing squid proxy server"
apt-get update
apt-get install squid3 libvirt-daemon-system apache2-utils iptables-persistent -y

echo "configuring squid whitelists"

echo "169.254.169.254 metadata.google.internal" >> /etc/hosts

cat <<EOF > /etc/squid/dst_whitelist.txt
${whitelist}
EOF

cat <<EOF > /etc/squid/src_whitelist.txt
metadata.google.internal
EOF

echo "squid configuration"
cat <<EOF > /etc/squid/squid.conf
${squid_config}
EOF

echo "environment variables config"
SQUID_SERVER="192.168.1.1"
# Interface connected to Internet
INTERNET="eth0"
# Interface connected to LAN
LAN_IN="eth1"
# Squid port
SQUID_PORT="3128"
# Clean old firewall

echo "configuring iptables"
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
echo 1 > /proc/sys/net/ipv4/ip_forward

echo  "Setting default filter policy"
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# Allow UDP, DNS and Passive FTP
iptables -A INPUT -i $INTERNET -m state --state ESTABLISHED,RELATED -j ACCEPT
# set this system as a router for Rest of LAN
iptables --table nat --append POSTROUTING --out-interface $INTERNET -j MASQUERADE
iptables --append FORWARD --in-interface $LAN_IN -j ACCEPT
# unlimited access to LAN
iptables -A INPUT -i $LAN_IN -j ACCEPT
iptables -A OUTPUT -o $LAN_IN -j ACCEPT
# DNAT port 80 request comming from LAN systems to squid 3128 ($SQUID_PORT) aka transparent proxy
iptables -t nat -A PREROUTING -i $LAN_IN -p tcp --dport 80 -j DNAT --to $SQUID_SERVER:$SQUID_PORT
iptables -t nat -A PREROUTING -i $INTERNET -p tcp --dport 80 -j REDIRECT --to-port $SQUID_PORT
# DROP everything and Log it
iptables -A INPUT -j LOG
iptables -A INPUT -j DROP

echo "restarting squid"
service squid restart

echo "saving iptables"
/sbin/iptables-save

echo "Configure Ops Agent log streams"
# TODO

echo "Healthcheck API"
# TODO


SQUID_SERVER="127.0.0.1"
# Interface connected to Internet
INTERNET="ens4"
# Interface connected to LAN
LAN_IN="lo"
# Squid port
SQUID_PORT="3128"
# Clean old firewall
systemctl start libvirtd


echo "environment variables config"
echo "Configure Ops Agent log streams"
# TODO

echo "Healthcheck API"
# TODO

