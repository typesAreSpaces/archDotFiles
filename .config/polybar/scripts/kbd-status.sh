#!/bin/bash

get_status() {
  [ ! -z "$(xmodmap | grep lock | grep 0x9)" ] && result="Caps is Esc"
  [ ! -z "$(xmodmap | grep lock | grep 0x42)" ] && result=""
  [ ! -z "$(xmodmap | grep lock | grep 0x25)" ] && result="Caps is Ctrl"
  [ ! -z "$(xmodmap | grep lock | grep 0x69)" ] && result="Caps is Ctrl"
  echo $result
}

if [ "$1" = '--once' ] ; then
  get_status
  exit
fi

while :; do
  get_status
  sleep 1
done
