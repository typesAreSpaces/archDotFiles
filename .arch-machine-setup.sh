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

# TODO: 
# - Remove polybar since it's in .arch_packages (?)
# - Keep it for now because paru doesn't list it 
# - on the database
#mkdir -p ~/Documents/GithubProjects/polybar
#git clone https://aur.archlinux.org/polybar.git ~/Documents/GithubProjects/polybar
#cd ~/Documents/GithubProjects/polybar && makepkg -si

# Change shell to zsh
chsh -s /bin/zsh
