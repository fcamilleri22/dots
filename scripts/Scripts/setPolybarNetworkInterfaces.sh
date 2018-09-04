#!/usr/bin/env bash
DIR=$HOME/Scripts
CFG=$HOME/.config/polybar/config
WIFI=$($DIR/getWifiInterfaceName.sh)
WIRED=$($DIR/getWiredInterfaceName.sh)



sed -r -i "
    /module\/wlan/, /module/ {
        s/interface =.*/interface = $WIFI/
    }" $CFG

sed -r -i "
    /module\/eth/, /module/ {
        s/interface =.*/interface = $WIRED/
    }" $CFG
