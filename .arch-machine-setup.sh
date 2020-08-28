#!/bin/bash

# ------------------------------------------------------------------------
# Dot files setup
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --bare git@github.com:typesAreSpaces/archDotFiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
mkdir -p .config-backup && \
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
config checkout
config config --local status.showUntrackedFiles no
source .zshrc
# ------------------------------------------------------------------------
# Vim setup
## Install Vim
sudo pacman -S vim
## Download vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
## Create undodir directory
mkdir -p ~/.vim/undodir
## Install vim plugins
vim +PlugInstall +qa
# ------------------------------------------------------------------------
# Installing my usual stuff
installArchPackages()
# ------------------------------------------------------------------------
