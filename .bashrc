#
# ~/.bashrc
#
export VISUAL=nvim    
export EDITOR=nvim

#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#    startx
#fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

function getSinkSource { 
  pacmd list-sinks | grep "index" | grep -o "[0-9]*" 
}
