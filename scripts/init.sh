#!/bin/bash
# Install all the bits that are needed

# Init apt database
apt-get update

REQUIRED_PACKAGES="
rfkill
net-tools
hostapd
"
apt-get install -y ${REQUIRED_PACKAGES}
