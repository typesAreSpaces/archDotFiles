#!/bin/bash

CONFIG="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Install additional programs
sudo pacman -S zsh git reflector rsync

# Update mirrorlist
sudo reflector --latest 100 --protocol https --country 'US' --sort age --save /etc/pacman.d/mirrorlist

# Setup dot files
echo ".cfg" >> .gitignore
git clone --bare \
  https://github.com/typesAreSpaces/archDotFiles.git \
  $HOME/.cfg
mkdir -p .config-backup && \
  $CONFIG checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}
$CONFIG checkout
$CONFIG config --local status.showUntrackedFiles no

# Installing my usual stuff
sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort .arch_packages))

# TODO:
# Install GithubProjects apps including:
# - bsp-layout
# - blog
# - paru - done
mkdir -p $HOME/Documents/GithubProjects/paru
sudo pacman -S --needed base-devel
git clone \
  https://aur.archlinux.org/paru.git \
  $HOME/Documents/GithubProjects/paru
cd $HOME/Documents/GithubProjects/paru && \
  makepkg -si
# - phd-thesis
# - QuickTex
# - QuickPandoc
# - slimlock (?)
# - typesAreSpaces.github.io
# - zathura-pywal

# Change shell to zsh
chsh -s /bin/zsh

# Setup python packages
# pip3 install pynvim

# Setup fonts
# TODO

# Install AUR packages
# using paru
# TODO mu
# TODO polybar

# Setup mu
# Create dirs $HOME/Mail/unm $HOME/Mail/cs-unm
# mu init --maildir=~/Mail --my-address=ADDRESS1 --my-address=ADDRESS2
# mu index
