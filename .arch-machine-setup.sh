#!/bin/bash

CONFIG="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Update repos
sudo pacman -Syu

# Update mirrorlist
sudo reflector --latest 100 --protocol https --country 'US' --sort age --save /etc/pacman.d/mirrorlist

# Install additional programs
sudo pacman -S zsh git reflector rsync

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
  mu-git \
  polybar \
  ttf-fira-code \
  betterlockscreen \
  xlsw

# Setup python packages
sudo pip3 install \
  pynvim \
  google-api-python-client \
  oauth2client

# Setup npm packages
# TODO alacritty-theme-switch
sudo npm install -g \
  alacritty-theme-switch

# Change shell to zsh
chsh -s /bin/zsh

# Manual settings

# Setup mu
# Create dirs $HOME/Mail/unm $HOME/Mail/cs-unm
mkdir -p $HOME/Mail/unm
mkdir -p $HOME/Mail/cs-unm
# Copy .mbsyncrc template from $HOME/.emacs.d/Emacs.org
# Manually, execute the following commands
# > mu init --maildir=~/Mail --my-address=ADDRESS1 --my-address=ADDRESS2
# > mu index

# Setup UnseenMail
# Manually add an accounts.ini file for UnseenMail
# in $HOME/.config/polybar/scripts/UnseenMail

# Setup bspwm
# Manually check correct MONITOR
# (use xrandr to check for available monitors)
# variable setting
# in $HOME/.config/bspwm/bspwmrc

# Setup ssh credentials
# Manually run the following
# > ssh-keygen -t ed25519 -C "email@example.com"
# > eval "$(ssh-agent -s)"
# Add public key to github personal accout 

# Install the following GithubProjects apps:
# - bsp-layout
# - blog
# - phd-thesis
# - QuickTex
# - QuickPandoc
# - typesAreSpaces.github.io
# - zathura-pywal
# - PersonalLatexMacros at $HOME/texmf/tex/latex/local

# Setup default apps
MIME_DIR="$HOME/.local/share/applications"
mkdir -p $MIME_DIR

# Zathura | application/pdf
touch $MIME_DIR/zathura.desktop
echo "[Desktop Entry]" >> $MIME_DIR/zathura.desktop
echo "Exec=/usr/bin/zathura %u" >> $MIME_DIR/zathura.desktop
xdg-mime default zathura.desktop application/pdf
