#! /bin/sh
setxkbmap
xmodmap $HOME/.Xmodmap
~/.local/scripts/UnseenMail/keep_checking_email.sh &
emacs --daemon
