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
#If you run this on a dirty install, or a completely different distribution,\
#things WILL break. You've been warned...
################################################################################

################################################################################
#1.) Ensure we're not running this as root, configure initial system level stuff
# (pacman, nano, etc.) and user .xinitrc
################################################################################

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

#Edit xinitrc so that .Xresources confs can be split into multiple files
sed -i 's/-merge /-merge -I /g'     $HOME/.xinitrc

################################################################################
#2.) Install Software from repositories
################################################################################


#Update mirrors + system
sudo pacman -Syyu --noconfirm

#Install from official repositories...
sudo pacman -S --noconfirm                                                      \
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
    libmpdclient                                                                \
    python-pip                                                                  \
    manjaro-pulse                                                               \
    pavucontrol                                                                 \
    pa-applet

yaourt -Syy --noconfirm

#Then, install from the User Repository...
#NOTE: rxvt-unicode-better-blah-blah causes a conflict with preinstalled
# rxvt-unicode.
yaourt -S --noconfirm                                                           \
    smartgit                                                                    \
    oh-my-zsh-git                                                               \
    nerd-fonts-fira-code                                                        \
    oomox

#Then, packages for the atom editor
#We can paralellize a few things from here on in to make things faster
$(
apm install                                                                     \                                                \
    pigments                                                                    \
    minimap                                                                     \
    minimap-pigments                                                            \
    minimap-highlight-selected                                                  \
    language-ini                                                                \
    language-terraform
) &
#Then, npm packages
#npm install -g...

#And pip packages too!
$(
sudo pip install --upgrade pip
sudo pip install                                                                \
    colorz                                                                      \
    haishoku                                                                    \
    colorthief
) &

wait

################################################################################
#3.) Create Projects Directory, clone dotfile repository, replace default confs
################################################################################

BRANCH="master" #what git branch of 'dots' to fetch other files from
PROJDIR="$HOME/Projects" #Where you want your "projects" directory to live
DOTDIR="$PROJDIR/dots" #Where you want to put the rest of the 'dots' git repo.

mkdir $PROJDIR
git clone -b $BRANCH https://github.com/fcamilleri22/dots.git $DOTDIR

#Stow scripts dir, and chmod them
stow --dir=$DOTDIR/ --target=$HOME/ scripts
chmod -R +x $HOME/Scripts/*

#Then handle the other stows.
$HOME/Scripts/stowConfigs.sh $DOTDIR

################################################################################
#4.) Initialize other packages, take care of things that require user intervention
################################################################################

#Ensure Polybar config has the correct network interface names
$HOME/Scripts/setPolybarNetworkInterfaces.sh

#Fix Firefox Textboxes under dark themes by forcing it to think it's a light theme
FFPREFSDIR=$(ls $HOME/.mozilla/firefox/ | grep .dev-edition-default)

echo 'user_pref("widget.content.gtk-theme-override", "Adwaita:light");'         \
    >>$HOME/.mozilla/firefox/$FFPREFSDIR/prefs.js

#run a default theme for next reboot
$HOME/Scripts/PATHed/retheme-by-builtin sexy-neon

#Change Shell
chsh $(whoami) -s /usr/bin/zsh

#set up a default wallpaper
WALLDIR=$HOME/Pictures/Wallpapers
WALL=pawel-nolbert-291146-unsplash.jpg

mkdir $WALLDIR
cp $DOTDIR/$WALL $WALLDIR
nitrogen --set-centered $WALLDIR/$WALL

##Leave things that require user intervention for the very end
#Set up MariaDB (see the ArchWiki for more info)
sudo mysql_install_db                                                           \
--user=mysql                                                                    \
--basedir=/usr                                                                  \
--datadir=/var/lib/mysql

sudo systemctl start mysqld
mysql_secure_installation

#Conflicts with regular rxvt-unicode, needs user intervention.
yaourt -S rxvt-unicode-better-wheel-scrolling-unicode3

echo "All done!!!"
echo -n "Rebooting in 5 seconds. Ctrl-C to cancel..."
sleep 5
reboot
