#!/bin/zsh

gruvboxTheme(){
  BG1="colour237"
  FG1="colour223"
  FG_LEFT="colour7"
  BG_LEFT="colour241"
  ALERT="colour45"
  FG_RIGHT1="colour246"
  FG_RIGHT2="colour109"
  FG_RIGHT3="colour248"
  BG_LINE="colour239"
  FG_CURRENT="colour214"
  FG_ACTIVITY="colour167"
  FG_BELL="colour235"
}

#TODO: setup proper colors
nordTheme(){
  BG1="colour237"
  FG1="colour223"
  FG_LEFT="colour7"
  BG_LEFT="colour241"
  ALERT="colour45"
  FG_RIGHT1="colour246"
  FG_RIGHT2="colour109"
  FG_RIGHT3="colour248"
  BG_LINE="colour239"
  FG_CURRENT="colour214"
  FG_ACTIVITY="colour167"
  FG_BELL="colour235"
}

#TODO: setup proper colors
tokyoTheme(){
  BG1="colour237"
  FG1="colour223"
  FG_LEFT="colour7"
  BG_LEFT="colour241"
  ALERT="colour45"
  FG_RIGHT1="colour246"
  FG_RIGHT2="colour109"
  FG_RIGHT3="colour248"
  BG_LINE="colour239"
  FG_CURRENT="colour214"
  FG_ACTIVITY="colour167"
  FG_BELL="colour235"
}

setTheme(){
  cp tmux.temp.conf tmux.conf
  sed -i "s/BG1/$BG1/g" tmux.conf
  sed -i "s/BG1/$BG1/g" tmux.conf
  sed -i "s/FG1/$FG1/g" tmux.conf
  sed -i "s/FG_LEFT/$FG_LEFT/g" tmux.conf
  sed -i "s/BG_LEFT/$BG_LEFT/g" tmux.conf
  sed -i "s/ALERT/$ALERT/g" tmux.conf
  sed -i "s/FG_RIGHT1/$FG_RIGHT1/g" tmux.conf
  sed -i "s/FG_RIGHT2/$FG_RIGHT2/g" tmux.conf
  sed -i "s/FG_RIGHT3/$FG_RIGHT3/g" tmux.conf
  sed -i "s/BG_LINE/$BG_LINE/g" tmux.conf
  sed -i "s/FG_CURRENT/$FG_CURRENT/g" tmux.conf
  sed -i "s/FG_ACTIVITY/$FG_ACTIVITY/g" tmux.conf
  sed -i "s/FG_BELL/$FG_BELL/g" tmux.conf
}

case $1 in
  "gruvbox")
    gruvboxTheme
    ;;
  "nord")
    nordTheme
    ;;
  "tokyo")
    tokyoTheme
    ;;
esac

setTheme
