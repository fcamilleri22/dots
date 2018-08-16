#!/bin/bash
################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: rotates wallpapers from a predefined directory
#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your stuff)
################################################################################

WALLPAPERDIR=$HOME/Pictures/Wallpapers

while true
do
    nitrogen --set-centered --random $WALLPAPERDIR
    sleep 10m
done
