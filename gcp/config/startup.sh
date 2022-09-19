#!/bin/bash

set -x # Debug
set -e # Strict exit codes

echo "Applying system patches"
sudo apt-get update;

sudo apt-get upgrade -y;


echo "Installing Ops Agent";
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh;
sudo bash add-google-cloud-ops-agent-repo.sh --also-install ;
rm add-google-cloud-ops-agent-repo.sh;

echo "Installing wget";
sudo apt-get install wget -y;

echo "Installing MITM Proxy";
wget https://snapshots.mitmproxy.org/8.1.1/mitmproxy-8.1.1-linux.tar.gz;
tar -zxvf mitmproxy-8.1.1-linux.tar.gz;
rm mitmproxy-8.1.1-linux.tar.gz;

echo "Apply MITM configuration";
echo "enable forwarding mode"; 
sudo sysctl -w net.ipv4.ip_forward=1;
sudo sysctl -w net.ipv6.conf.all.forwarding=1;

echo "disable ICMP redirects";
sudo sysctl -w net.ipv4.conf.all.send_redirects=0;

echo "configure iptables";

sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080;
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080;
sudo ip6tables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080;
sudo ip6tables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080;

echo "start mitmproxy";
./mitmproxy --mode transparent --showhost;


echo "Configure Ops Agent log streams";
# TODO

echo "Healthcheck API";
# TODO
