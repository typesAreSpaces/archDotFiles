#!/bin/bash

CONFIG='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Extra programs
sudo pacman -S zsh git

# Dot files setup
echo ".cfg" >> .gitignore
git clone --bare https://github.com/typesAreSpaces/archDotFiles.git $HOME/.cfg
mkdir -p .config-backup && \
  $CONFIG checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
$CONFIG checkout
$CONFIG config --local status.showUntrackedFiles no

# ------------------------------------------------------------------------
# Installing my usual stuff
sudo pacman -S --needed - < .arch_packages 

# TODO:
# Install GithubProjects apps including:
# - bsp-layout
# - blog
# - paru
# - phd-thesis
# - QuickTex
# - slimlock (?)
# - typesAreSpaces.github.io
# - zathura-pywal

# ------------------------------------------------------------------------
# TODO: 
# - Remove polybar since it's in .arch_packages
# - Keep it for now to replicate installation 
# - for the above GithubProjects apps
mkdir -p ~/Documents/GithubProjects/polybar
git clone https://aur.archlinux.org/polybar.git ~/Documents/GithubProjects/polybar
cd ~/Documents/GithubProjects/polybar && makepkg -si

# Change shell to zsh
chsh -s /bin/zsh
