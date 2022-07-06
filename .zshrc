# Path to your oh-my-zsh installation.
export ZSH="/home/dinghy/.oh-my-zsh"

ZSH_THEME="af-magic"
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml


# For fzf plugin to allow ** syntax for searching
export FZF_BASE=/usr/bin/fzf

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git vi-mode rust command-not-found sudo fzf)


source $ZSH/oh-my-zsh.sh

# use `dotfiles` for managing and saving dotfiles remotely
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias s=systemctl

# conda will not play nicely with zsh
# `zsh -l` allows ability to activate conda envs
#
# export PATH='/Users/dinghy/miniconda3/bin:$PATH'

LIGHT_THEME_FOUND="$(cat ~/.config/alacritty/alacritty.yml | grep '*light')"
if [ ! -z $LIGHT_THEME_FOUND ]; then
	export THEME_CONTEXT='light'
else
	export THEME_CONTEXT='dark'
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
function conda_init {
    __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/opt/miniconda3/etc/profile.d/conda.sh"
        else
              export PATH="$PATH:/opt/miniconda3/bin"
        fi
    fi
    unset __conda_setup
}
# <<< conda initialize <<<

# dude seriously conda & my zsh just don't mix. `clear` doesn't work with the previous block.

# Get utils like theme-switch available
export PATH="/home/dinghy/.local/bin:/home/dinghy/utils:$PATH"

# Something something autocomplete ??? profit. we will see
eval "$(starship init zsh)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(kubectl completion zsh)
alias k=kubectl
