#!/usr/bin/env bash
################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: rotates wallpapers from a predefined directory
#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your stuff)
################################################################################
#Note: depends on WALLPAPERDIR from ~/.profile

while true
do
    nitrogen --set-zoom-fill --random $WALLPAPERDIR
    sleep 10m
done
