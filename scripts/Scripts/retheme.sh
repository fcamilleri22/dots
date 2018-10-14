#!/usr/bin/env bash
################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: a wrapper for pywal to simplify retheming.
#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your stuff)
################################################################################

wal -g -a 85 --saturate 0.9 -n $@

#don't continue if error in wal
[ $? -ne 0 ] && exit 1

WALCACHE=$HOME/.cache/wal
#Atom Theme
cp \
    $WALCACHE/colors-atom-syntax \
    $HOME/.atom/packages/frank-syntax/styles/colors.less

#Dunst (notification daemon) Theme
cp \
    $WALCACHE/colors-dunst \
    $HOME/.config/dunst/dunstrc

#i3lock
cp \
    $WALCACHE/colors-i3lock-color \
    $HOME/Scripts/lockscreen.sh
chmod +x $HOME/Scripts/lockscreen.sh

#Intellj
IDEACONFDIR=$(ls -a $HOME | grep .IdeaIC)
IDEACONFDIR=$HOME/$IDEACONFDIR/config
$HOME/Scripts/intellijPywal/intellijPywalGen.sh "$IDEACONFDIR"

echo "Some programs, such as Atom and Intellij, may need to be restarted for changes to take effect."
