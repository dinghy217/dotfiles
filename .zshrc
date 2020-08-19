# Path to your oh-my-zsh installation.
export ZSH="/home/dinghy/.oh-my-zsh"

ZSH_THEME="af-magic"


# For fzf plugin to allow ** syntax for searching
export FZF_BASE=/usr/bin/fzf

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git vi-mode cargo command-not-found sudo fzf)


source $ZSH/oh-my-zsh.sh

# use `dotfiles` for managing and saving dotfiles remotely
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# conda will not play nicely with zsh
# `zsh -l` allows ability to activate conda envs
