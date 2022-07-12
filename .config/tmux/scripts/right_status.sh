#!/bin/bash

function check_email() {
  email="$(cat ~/.unread_email | xargs)"
  if [ -z "$email" ]
  then
    printf "%s" "#[fg=colour109]  X"
  else
    printf "%s" "#[fg=colour109] ${email}"
  fi
}

function _date() {
  printf "%s" "#[fg=colour246, bg=colour237]  $(date +'%b %d %y')"
}

function _time() {
  printf "%s" "#[fg=colour109]  $(date +'%H:%M:%S %Z') #[fg=colour248, bg=colour239]"
}

function main() {
  check_email
  _date
  _time
}

main
