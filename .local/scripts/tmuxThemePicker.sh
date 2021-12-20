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
  BG1="#1F2335"
  FG1="white"
  FG_LEFT="black"
  BG_LEFT="green"
  ALERT="blue"
  FG_RIGHT1="white"
  FG_RIGHT2="white"
  FG_RIGHT3="white"
  BG_LINE="#1F2335"
  FG_CURRENT="brightwhite"
  FG_ACTIVITY="colour167"
  FG_BELL="colour235"
}

setTheme(){
  TMUX_PATH=$HOME/.config/tmux
  cp $TMUX_PATH/tmux.temp.conf $TMUX_PATH/tmux.conf
  sed -i "s/BG1/$BG1/g" $TMUX_PATH/tmux.conf
  sed -i "s/BG1/$BG1/g" $TMUX_PATH/tmux.conf
  sed -i "s/FG1/$FG1/g" $TMUX_PATH/tmux.conf
  sed -i "s/FG_LEFT/$FG_LEFT/g" $TMUX_PATH/tmux.conf
  sed -i "s/BG_LEFT/$BG_LEFT/g" $TMUX_PATH/tmux.conf
  sed -i "s/ALERT/$ALERT/g" $TMUX_PATH/tmux.conf
  sed -i "s/FG_RIGHT1/$FG_RIGHT1/g" $TMUX_PATH/tmux.conf
  sed -i "s/FG_RIGHT2/$FG_RIGHT2/g" $TMUX_PATH/tmux.conf
  sed -i "s/FG_RIGHT3/$FG_RIGHT3/g" $TMUX_PATH/tmux.conf
  sed -i "s/BG_LINE/$BG_LINE/g" $TMUX_PATH/tmux.conf
  sed -i "s/FG_CURRENT/$FG_CURRENT/g" $TMUX_PATH/tmux.conf
  sed -i "s/FG_ACTIVITY/$FG_ACTIVITY/g" $TMUX_PATH/tmux.conf
  sed -i "s/FG_BELL/$FG_BELL/g" $TMUX_PATH/tmux.conf
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
