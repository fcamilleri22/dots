#!/bin/bash
################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: a wrapper for pywal to simplify retheming.
#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your stuff)
################################################################################

wal -g -a 85 --saturate 0.9 -n $@

#don't continue if error in wal
[ $? -ne 0 ] && exit 1

#Atom Theme
cp \
    $HOME/.cache/wal/colors-atom-syntax \
    $HOME/.atom/packages/frank-syntax/styles/colors.less

#Dunst (notification daemon) Theme
cp \
    $HOME/.cache/wal/colors-dunst \
    $HOME/.config/dunst/dunstrc

cp \
    $HOME/.cache/wal/colors-i3lock-color \
    $HOME/Scripts/lockscreen.sh
chmod +x $HOME/Scripts/lockscreen.sh

echo "Some programs may need to be restarted for changes to take effect."
