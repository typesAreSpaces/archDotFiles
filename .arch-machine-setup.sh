#!/bin/bash

sudo pacman -S zsh git vim

# ------------------------------------------------------------------------
# Dot files setup
echo ".cfg" >> .gitignore
git clone --bare https://github.com/typesAreSpaces/archDotFiles.git $HOME/.cfg
mkdir -p .config-backup && \
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
# ------------------------------------------------------------------------
# Vim setup
## Download vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
## Create undodir directory
mkdir -p ~/.vim/undodir
## Install vim plugins
vim +PlugInstall +qa
# ------------------------------------------------------------------------
# Installing my usual stuff
sudo pacman -S --needed - < .arch_packages 
# ------------------------------------------------------------------------
chsh -s /bin/zsh
