#!/bin/bash

sudo pacman -S zsh
/bin/zsh

# ------------------------------------------------------------------------
# Dot files setup
echo ".cfg" >> .gitignore
git clone --bare git@github.com:typesAreSpaces/archDotFiles.git $HOME/.cfg
mkdir -p .config-backup && \
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
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
chsh -s /bin/zsh
