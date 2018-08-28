#!/usr/bin/env bash
################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: run this after pulling a new version of dots.
#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your stuff)
################################################################################

#Determine if root or 'nobody'. If either, exit script.
if [ $UID -eq 0 ] || [ $UID -eq 99 ]
then
    echo "ERROR: This script should be invoked by the primary user, and definitely not root. Exiting."
    exit 1
fi

#Set where we're looking for the (possibly updated) install script.
SCRIPTDIR=$1
[ -z "$SCRIPTDIR" ] && SCRIPTDIR=$HOME/Projects/dots/postInstall.sh

#Determine if postInstall.sh exists where we want it, or exit.
if [ ! -e $SCRIPTDIR ]
then
    echo "$SCRIPTDIR doesn't exist! Exiting."
    exit 1
fi

#Rerun section 2 of the install script.
#This includes a full system update.
sh -c "$(cat $SCRIPTDIR | sed -n "/#2.)/,/#3.)/p")"

#Handle config files.
$HOME/Scripts/stowConfigs.sh $(dirname $SCRIPTDIR)

#Ensure your username still exists in .Xresources for i3
if [ -z "$(cat $HOME/.Xresources | grep username:\ $(whoami))" ]
then
    echo "username: $(whoami)" >>$HOME/.Xresources
fi
