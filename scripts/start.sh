#!/bin/bash
# Start the AP process (hostapd)

# Setup the env
: ${INTERFACE:="wlan0"}
: ${HW_ADDRESS:="12:34:56:78:90:AB"}
: ${HW_MODE:="g"}
: ${AP_SSID:="github.com/deanydean/gated"}
: ${AP_CHANNEL:="1"}
: ${WPA_PASSPHRASE:="letmeinNOW"}
: ${IP_ADDRESS:="192.168.0.1/24"}

# Generate a config file
cat >> /opt/gated/etc/hostapd.conf << xxxEOFxxx
# Generated $(date) during container startup
interface=${INTERFACE}
hw_mode=${HW_MODE}
ssid=${AP_SSID}
channel=${AP_CHANNEL}
wpa_passphrase=${WPA_PASSPHRASE}
xxxEOFxxx

# Setup the system
/usr/sbin/rfkill unblock wlan
/sbin/ifconfig ${INTERFACE} down hw ether ${HW_ADDRESS}
/sbin/ifconfig ${INTERFACE} ${IP_ADDRESS}

# Start hostapd
/usr/sbin/hostapd ${HOSTAPD_ARGS} /opt/gated/etc/hostapd.conf
