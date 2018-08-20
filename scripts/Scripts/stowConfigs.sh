#!/usr/bin/env bash
#Clear out prebaked configs to prevent stow conflicts, then stow repo config.
#NOTE: This needs to be rerun every time the dots repo is updated.
DOTDIR=$1

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
