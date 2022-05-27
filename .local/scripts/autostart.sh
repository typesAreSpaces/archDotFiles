#! /bin/sh
setxkbmap
xmodmap $HOME/.Xmodmap
emacs --daemon
