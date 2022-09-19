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
# TODO

echo "Configure Ops Agent log streams";
# TODO

echo "Healthcheck API";
# TODO


sudo reboot;