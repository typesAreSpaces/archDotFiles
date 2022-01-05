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

# Install packages
sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort .arch_packages))

# Install paru
mkdir -p $HOME/Documents/GithubProjects/paru
sudo pacman -S --needed base-devel
git clone \
  https://aur.archlinux.org/paru.git \
  $HOME/Documents/GithubProjects/paru
cd $HOME/Documents/GithubProjects/paru && \
  makepkg -si

# Install AUR packages
paru -S \
  mu \
  polybar \
  ttf-fira-code \
  betterlockscreen

# Setup python packages
sudo pip3 install \
  pynvim \
  google-api-python-client \
  oauth2client

# Setup npm packages
# TODO alacritty-theme-switch
sudo npm install -g \
  alacritty-theme-switch

# Setup mu
# Create dirs $HOME/Mail/unm $HOME/Mail/cs-unm
mkdir -p $HOME/Mail/unm
mkdir -p $HOME/Mail/cs-unm
# Copy .mbsyncrc template from $HOME/.emacs.d/Emacs.org
# Manually, execute the following commands
# > mu init --maildir=~/Mail --my-address=ADDRESS1 --my-address=ADDRESS2
# > mu index

# Setup bspwm
# Manually check correct MONITOR
# (use xrandr to check for available monitors)
# variable setting
# in $HOME/.config/bspwm/bspwmrc

# Change shell to zsh
chsh -s /bin/zsh

# Setup ssh credentials
# Manually run the following
# > ssh-keygen -t ed25519 -C "email@example.com"
# > eval "$(ssh-agent -s)"
# Add public key to github personal accout 

# Install GithubProjects apps including:
# - bsp-layout
# - blog
# - phd-thesis
# - QuickTex
# - QuickPandoc
# - typesAreSpaces.github.io
# - zathura-pywal
