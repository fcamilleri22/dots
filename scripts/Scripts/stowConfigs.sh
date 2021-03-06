#!/usr/bin/env bash
#Clear out prebaked configs to prevent stow conflicts, then stow repo config.

DOTDIR=$1
[ -z "$DOTDIR" ] && DOTDIR=$HOME/Projects/dots

if [ $UID -eq 0 ] || [ $UID -eq 99 ]
then
    echo "ERROR: This script should be invoked by the primary user, and definitely not root. Exiting."
    exit 1
fi

swapAndStow () {
    PKG=$1
    shift
    rm -rf "$@"
    stow --dir=$DOTDIR/ --target=$HOME/ $PKG
}

swapAndStow i3      $HOME/.i3                                           &
swapAndStow polybar $HOME/.config/polybar                               &
swapAndStow wal     $HOME/.config/wal                                   &
swapAndStow atom    $HOME/.atom/config.cson                             &
swapAndStow gtk     $HOME/.gtkrc-2.0 $HOME/.config/gtk-3.0/settings.ini &
swapAndStow shell   $HOME/.Xresources $HOME/.zshrc $HOME/.profile       &

wait

echo "Config Symlinking Successful!"
