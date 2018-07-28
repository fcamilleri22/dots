#!/bin/bash
################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: installs Frank's preferred programs/configs in a single script invokation

#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your stuff)
################################################################################
#This script is meant to be invoked right after a fresh install of Manjaro i3
#Community Edition (maintained by Oberon) straight from wget using:
#bash -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/$BRANCH/postInstall.sh -O -)"
#If you run this on a dirty install, or a completely different distribution, things WILL break.
################################################################################

################################################################################
#1.) Ensure we're not running this as root, configure pacman mirrors for optimal
#download speeds, and edit (not replace) other system-wide config files in /etc/
#such as GNU Nano and the Pacman/Yaourt package managers.
################################################################################

BRANCH="master" #what git branch of 'dots' to fetch other files from
PROJDIR="$HOME/Projects" #Where you want your "projects" directory to live
DOTDIR="$PROJDIR/dots" #Where you want to put the rest of the 'dots' git repo.


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
sudo sed -i '/set mouse/s/^#//'                                 /etc/nanorc
sudo sed -i '/set linenumbers/s/^#//'                           /etc/nanorc
sudo sed -i '/set tabstospaces/s/^#//'                          /etc/nanorc

sudo sed -i '/set tabsize 8/s/8$/4/'                            /etc/nanorc
sudo sed -i '/set tabsize 4/s/^#//'                             /etc/nanorc

sudo sed -i '/include \"\/usr\/share\/nano\/\*.nanorc\"/s/^#//' /etc/nanorc



################################################################################
#2.) Install required software from Official repositories and User repository.
################################################################################

#S: use pacman in synchronize (install/update) mode
#y: refresh remote pacman package database.
#second y: force package database refresh because we updated the mirrorlist a
#few lines ago
#u: upgrade all out-of-date installed packages maintained in the Manjaro/Arch repos.
#In summary: tell pacman to respond to our config changes, and get the base
#system fully up to date before we start adding things on.
sudo pacman -Syyu

#Install from official repositories...
sudo pacman -S                                                                  \
    base-devel                                                                  \
    yaourt                                                                      \
    bind-tools                                                                  \
    zsh                                                                         \
    stow                                                                        \
    gucharmap                                                                   \
    mariadb                                                                     \
    mysql-workbench                                                             \
    nodejs                                                                      \
    npm                                                                         \
    atom                                                                        \
    apm	                                                                        \
    git                                                                         \
    firefox-developer-edition                                                   \
    python-pywal                                                                \
    polybar                                                                     \
    rofi                                                                        \
    terraform                                                                   \
    nerd-fonts-terminus                                                         \
    ttf-ubuntu-font-family                                                      \
    jsoncpp                                                                     \
    libmpdclient

#Yaourt has almost identical arguments to Pacman.
#Syy means "force package database refresh, but do NOT do any updates yet (no 'u')".
#Also, DO NOT use yaourt as root -- let the AURs included PKGBUILDs handle perms.
yaourt -Syy

#Then, install from the User Repository...
yaourt -S                                                                       \
    smartgit                                                                    \
    oh-my-zsh-git                                                               \
    nerd-fonts-fira-code                                                        \
    oomox


################################################################################
#3.) Initial setup for MariaDB, Atom Editor, and NodeJS Globals
################################################################################

#Set up MariaDB (see the ArchWiki for more info)
sudo mysql_install_db                                                           \
    --user=mysql                                                                \
    --basedir=/usr                                                              \
    --datadir=/var/lib/mysql

sudo systemctl start mysqld
mysql_secure_installation

#Atom plugins
apm install                                                                     \
    gruvbox-plus-syntax                                                         \
    pigments                                                                    \
    minimap                                                                     \
    minimap-pigments                                                            \
    minimap-highlight-selected                                                  \
    language-ini                                                                \
    language-terraform

#npm install -g...

################################################################################
#4.) Create Projects directory, clone full 'dots' repository inside of it,
#and replace default user configurations with symlinks to our configs via stow.
################################################################################

mkdir $PROJDIR
git clone -b $BRANCH https://github.com/fcamilleri22/dots.git $DOTDIR

#Clear out prebaked configs to prevent stow conflicts, then stow repo config.
rm -rf $HOME/.i3
stow --dir=$DOTDIR/ --target=$HOME/ i3

rm -rf $HOME/.config/polybar
stow --dir=$DOTDIR/ --target=$HOME/ polybar

rm -rf $HOME/.config/wal
stow --dir=$DOTDIR/ --target=$HOME/ wal

rm -rf $HOME/.config/dunst
stow --dir=$DOTDIR/ --target=$HOME/ dunst

rm -rf $HOME/.config/rofi
stow --dir=$DOTDIR/ --target=$HOME/ rofi

rm -f $HOME/.Xresources $HOME/.zshrc $HOME/.profile
stow --dir=$DOTDIR/ --target=$HOME/ shell

################################################################################
#5.) Finalize. Deal with any loose ends.
################################################################################

#Fix Firefox Textboxes under dark themes by forcing it to think it's a light theme
FFPREFSDIR=$(ls $HOME/.mozilla/firefox/ | grep .dev-edition-default)

echo 'user_pref("widget.content.gtk-theme-override", "Adwaita:light");'         \
    >>$HOME/.mozilla/firefox/$FFPREFSDIR/prefs.js

#Change Shell
chsh -s /usr/bin/zsh

echo "All done!"
echo "You should reboot this computer to ensure all changes take effect using 'sudo reboot'"
