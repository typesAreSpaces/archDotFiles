#! /bin/sh

setxkbmap
xmodmap $HOME/.Xmodmap
echo "CTRL" > ~/.current_binding
[ -f $HOME/.xsessionrc ] && source $HOME/.xsessionrc
[ "$(ps aux | grep 'bin.*keep_checking_email.sh' | wc -l | xargs)" = "1" ] && $HOME/.local/scripts/UnseenMail/keep_checking_email.sh&
[ "$(ps aux | grep 'emacs' | wc -l | xargs)" = "1" ] && emacs --daemon
