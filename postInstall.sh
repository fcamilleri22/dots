#!/bin/bash
################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: installs Frank's preferred programs/configs in a single script invokation
#Extra comments included because "the children are our future."
#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your shit)
################################################################################
#This script is meant to be invoked right after a fresh install of Manjaro i3
#Community Edition (maintained by Oberon) straight from wget using:
#bash -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/$BRANCH/postInstall.sh -O -)"
#If you run this on a dirty install, or a completely different distribution,
#things WILL break.
################################################################################
#On the OBNOXIOUS AMOUNT OF COMMENTS in this script:
#I got VERY deliberately overly verbose with my comment style here - my own
#entry into the greater Linux world more than 12 years ago started off with
#writing similar post install scripts for ubuntu-minimal and debian in the hope
#of having a unique/better/safer/faster than Windows gaming/media center setup.
#An entire career in software/computer engineering kinda sprouted out of that.

#The comments are targeted towards early high school aged computaphiles that
#know slightly more than the average power user or adults looking to go deep into
#"advanced" linux for the first time, and not professional developers 5+ years
#into their careers. I figure this is a good spot to slow things down and start
#to explain a few things to future generations.

#I'm also very likely to move these comments into README.md when i'm semi-done.
################################################################################

################################################################################
#TODOs (other than what's mentioned inline)
#Short term TODO list

#Refactor small repetitions

#Write/make accessible cheat sheet for i3/other Frankdot-specific items

#Connect link to raw format GitHub page to a deployfrank.sh subdomain in order to
#make the wget command memorable/write-down-able -- something to the effect of:
#bash -c "$(wget http://autoconfig.deployfrank.com -O -)"

#Complete i3 and Rofi configurations, including i3 saved layouts
################################################################################

################################################################################
#Standing TODO list

#Include polybar config options for screens smaller than 1080p (if demand)

#Try a lighter base with fewer "moving parts" -- currently, using Manjaro i3 as
#a base does a good job of filling in a lot of low level blanks I don't want to
#think about right now. Later though, I definitely want to consider using the
#Manjaro Architect ISO, possibly Antergos, even maybe good 'ol ArchLinux

#Make theming more friendly ...somehow
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
#Running this as root will make your system more vulnerable to the possibility
#of a malicious AUR PKGBUILD script, as well as screw up the position of $HOME.
if [ $UID -eq 0 ] || [ $UID -eq 99 ]
then
    echo "ERROR: This script must be invoked by a regular, non-root user. Exiting."
    exit 1
fi

#Update Repos/get nearest repos -- omit ibiblio, is slow.
#DISTANT TODO: Detect nation or continent -- geoip arg too slow, and some Canadian
#mirrors are totally fast enough for use inside the US, or continental EU mirrors
#for Great Britain, etc. (If demand)
sudo pacman-mirrors -c United_States
sudo sed -i '/ibiblio/d' /etc/pacman.d/mirrorlist

#For /etc/ level configs, I personally prefer to edit via sed than to include
#and maintain full config files since that if config file formats/options for
#system level programs change, it would be a much bigger issue to fix/update my
#configs according to the Manjaro/Arch maintainers changes.

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
#few lines of code ago
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
    terraform                                                                   \
    nerd-fonts-terminus                                                         \
    ttf-ubuntu-font-family                                                      \
    jsoncpp                                                                     \
    libmpdclient

#base-devel: prereq for Yaourt -- essentially a C/C++ toolchain
#yaourt: a secondary package manager for Arch Linux User Repository (AUR) packages.
#bind-tools: dns tools such as 'dig' and 'host.'
#zsh: a standards-compliant alternate bash-like shell with nice plugins.
#stow: a tool invoked later in this script for managing bundles of symlinks.
# This enables us to link my custom configs to their programs and update theme
# more easily.
#gucharmap: GUI Character map, useful for working with fonts with icons and
# non-standard Unicode icons.
#mariadb: a MySQL server for MySQL development.
#mysql-workbench: a (honestly quite bad, someone please suggest a replacement)
# front end for administering MySQL servers.
#nodejs, npm: runtime and package management for NodeJS development
#atom, apm: Modern text editor similar to Notepad++ or Sublime text and its
# associated package (plugin) manager.
#git: Everyone's favorite source control!
#firefox-developer-edition: web browser with good dev tools.
#python-pywal: script used for facilitating custom UI theme creation.
#polybar: the "taskbar." i3bar is nice, but this is nicer.
#nerd-fonts-terminus: font used in live terminals, patched with emojis and icons.
#ttf-ubuntu-font-family: systemwide default sans-serif fonts. They're pretty.
#libmpdclient and jsoncpp are improperly linked prereqs of polybar

#Yaourt has almost identical arguments to Pacman.
#Syy means "force package database refresh, but do NOT do any updates yet (no 'u')".
#Also, DO NOT use yaourt as root -- let the AURs included PKGBUILDs handle perms.
yaourt -Syy

#Then, install from the User Repository...
#TODO: Intellij Community Edition
yaourt -S                                                                       \
    smartgit                                                                    \
    oh-my-zsh-git                                                               \
    nerd-fonts-fira-code                                                        \
    oomox

#smartgit: a really good Git GUI. Requires paid license, but can be used for free.
# Please send these people your money. They deserve it.
#oh-my-zsh-git: plugin manager for zsh, from github.com/robbyrussell/oh-my-zsh
#nerd-fonts-fira-code: AKA 'Fura Code' - font used in editors/other code not inside
# live terminals. Includes emojis and icons, as well as programming ligatures.
#oomox: a sexual act perfomed amongst consenting Ferengi. Also, a GTK theme generator
# that works wonderfully with python-pywal

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
#TODO: Fill as you go along.
apm install                                                                     \
    gruvbox-plus-syntax                                                         \
    pigments                                                                    \
    minimap                                                                     \
    minimap-pigments                                                            \
    minimap-highlight-selected                                                  \
    language-ini                                                                \
    language-terraform

#TODO: nodejs globals, like underscore-cli
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

rm -f $HOME/.Xresources $HOME/.zshrc $HOME/.profile
stow --dir=$DOTDIR/ --target=$HOME/ shell

################################################################################
#5.) Finalize. Deal with any loose ends (small fixes, shell change, etc)
################################################################################

chsh -s /usr/bin/zsh

#TODO: wal post-run script for atom/rofi/dunst
#TODO: Firefox dark text box fix

#TODO: Fonts
#Serif: TBD
#Sans-Serif: Ubuntu 12
#Mono (terminal): Nerd Fonts Terminus
#Mono (editor): Nerd Fonts Fura Code

#TODO: Frank Specific Addendums (secrets, other git repos, wallpaper library)
