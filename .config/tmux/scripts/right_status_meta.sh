#!/bin/bash

function check_email() {
  email="$(cat ~/.unread_email | xargs)"
  if [ -z "$email" ]
  then
    printf "%s" "#[fg=FG_RIGHT2]  X"
  else
    printf "%s" "#[fg=FG_RIGHT2] ${email}"
  fi
}

function _date() {
  printf "%s" "#[fg=FG_RIGHT1, bg=BG1]  $(date +'%b %d %y')"
}

function _time() {
  printf "%s" "#[fg=FG_RIGHT2]  $(date +'%H:%M:%S %Z') #[fg=FG_RIGHT3, bg=BG_LINE]"
}

function main() {
  check_email
  _date
  _time
}

main
