################################################################################
#Author: Frank Camilleri (http://deployfrank.sh)
#TL;DR: dot-zsh file. User defined SHELL CONFIGURATIONS + ALIASES go here. NOT SHELL VARIABLES.
#License: MIT (do w/e you want with this code as long as MIT license copy
#included, and I'm not responsible if this code breaks your stuff)
################################################################################
ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="xiong-chiamiov-plus"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  colored-man-pages
  web-search
)

#User configuration
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

#Configure Less (the file reader) so we can scroll manpages with the mouse.
export LESS=-R

source $ZSH/oh-my-zsh.sh
