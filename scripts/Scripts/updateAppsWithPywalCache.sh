#!/bin/bash
################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: Takes themed config files from the pywal cache and puts them where they
#need to be. Run with pywal using 'wal -o ...'
#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your stuff)
################################################################################

#Atom Theme
mv \
    $HOME/.cache/wal/colors-atom-syntax \
    $HOME/.atom/packages/frank-syntax/styles/colors.less

#Dunst (notification daemon) Theme
