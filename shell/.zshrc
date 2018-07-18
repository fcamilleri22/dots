#ZSH configuration
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

source $ZSH/oh-my-zsh.sh
