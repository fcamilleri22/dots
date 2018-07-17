#!/usr/bin/bash
#Author: Frank Camilleri
#This Script is to be invoked right after a fresh install of Manjaro i3
#Community Edition straight from wget using:
#bash -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/$BRANCH/postInstall.sh -O -)"

BRANCH="master"

#Determine if root or 'nobody'. If either, exit script.
if [ $UID -eq 0 ] || [ $UID -eq 99 ]
then
    echo "ERROR: This script must be invoked by a regular, non-root user. Exiting."
    exit 1
fi

#Update Repos/get nearest repos -- omit ibiblio, is slow.
sudo pacman-mirrors -c United_States
sudo sed -i '/ibiblio/d' /etc/pacman.d/mirrorlist

#Edit default /etc/pacman.conf (purely aesthetics)
sudo sed -i '/Color/s/^#//'           /etc/pacman.conf
sudo sed -i '/TotalDownload/s/^#//'   /etc/pacman.conf
sudo sed -i '/VerbosePkgLists/s/^#//' /etc/pacman.conf

#Edit default /etc/nanorc:
sudo sed -i '/set autoindent/s/^#//'                            /etc/nanorc
sudo sed -i '/set boldtext/s/^#//'                              /etc/nanorc
sudo sed -i '/set mouse/s/^#//'                                 /etc/nanorc
sudo sed -i '/set linenumbers/s/^#//'                           /etc/nanorc
sudo sed -i '/set tabstospaces/s/^#//'                          /etc/nanorc

sudo sed -i '/set tabsize 8/s/8$/4/'                            /etc/nanorc
sudo sed -i '/set tabsize 4/s/^#//'                             /etc/nanorc

sudo sed -i '/include \"\/usr\/share\/nano\/\*.nanorc\"/s/^#//' /etc/nanorc

#Update already installed packages/refresh caches
sudo pacman -Syyu

#Get non-aur stuff
sudo pacman -S                                                                  \
    base-devel                                                                  \
    yaourt                                                                      \
    dnsutils                                                                    \
    gucharmap                                                                   \
    mariadb                                                                     \
    mysql-workbench                                                             \
    nodejs                                                                      \
    npm                                                                         \
    zsh                                                                         \
    atom                                                                        \
    git                                                                         \
    apm	                                                                        \
    firefox-developer-edition                                                   \
    python-pywal                                                                \
    polybar                                                                     \
    nerd-fonts-terminus                                                         \
    ttf-ubuntu-font-family                                                      \
    stow                                                                        \


#Update package caches/Install Packages from Arch User Repository
yaourt -Syu

yaourt -S                                                                       \
    smartgit                                                                    \
    oh-my-zsh-git                                                               \
    nerd-fonts-fira-code                                                        \

#Set up MariaDB
sudo mysql_install_db                                                           \
    --user=mysql                                                                \
    --basedir=/usr                                                              \
    --datadir=/var/lib/mysql                                                    \

sudo systemctl start mysqld
mysql_secure_installation

#Atom plugins
#TODO: Fill as you go along.
apm install                                                                     \
    gruvbox-plus-syntax                                                         \
    pigments                                                                    \
    minimap                                                                     \
    minimap-pigments                                                            \
    minimap-highlight-selected                                                  \
    character-table                                                             \
    language-ini                                                                \

#TODO Create "Projects" Directory, and properly clone entire dots repo

#TODO: Get/link Dotfiles/other configs
#i3config
#zshrc
#xinitrc
#i3lock?

#Clear out prebaked configs
rm -rf $HOME/.i3
#Stow configs from repo
stow --dir=$HOME/Projects/dots/i3 --target=$HOME/


#TODO: ZSH configs
#oh-my-zsh from the AUR ends up in /usr/share/oh-my-zsh

#TODO: Alter firefox fonts in ~/.mozilla/firefox/*.default

#TODO: Configure theme colors (Pywal, polybar, oomox, etc)
#TODO: Fonts
#Serif: TBD
#Sans-Serif: Ubuntu 12
#Mono (terminal): Nerd Fonts Terminus
#Mono (editor): Nerd Fonts Fura Code

#TODO: Frank Specific Addendums (secrets, other git repos, wallpaper library)
