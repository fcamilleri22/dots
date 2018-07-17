#!/usr/bin/bash

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
    adobe-source-code-pro-fonts                                                 \
    adobe-source-sans-pro-fonts                                                 \
    adobe-source-serif-pro-fonts                                                \

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


#TODO: Get Settings/Backups/configs from git -- then link them
#i3config
#zshrc
#xinitrc
#i3lock

#TODO: ZSH configs
#oh-my-zsh from the AUR ends up in /usr/share/oh-my-zsh

#TODO: Alter firefox fonts in ~/.mozilla/firefox/*.default

#TODO: Configure Pywal(finish i3 config), polybar, finalize fonts
