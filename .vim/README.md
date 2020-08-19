# Setup i3

```
pacman -S xorg

# Take i3-gaps
pacman -S i3
pacman -S lightdm
pacman -S i3status-rust
yay -S lightdm-webkit-theme-aether
```

# Vim Setup Prereqs

```
pacman -S universal-tags
pacman -S bat
pacman -S the_silver_searcher
pacman -S fzf

# For YouCompleteMe
pacman -S cmake
pacman -S npm
```

Setup vim-plug as plugin manager
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

# Copy Config Files

Clone and install .dotfiles from this repo<sup>1</sup>
```
git clone --bare https://github.com/dinghy/dotfiles.git $HOME/dotfiles
```

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

```
dotfiles checkout
```

# Install Plugins

Open `vim`. Run `:PlugInstall`. Pray it works.



<sup>1</sup>Reference: https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b
