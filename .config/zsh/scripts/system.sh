update(){
  echo ">>> Update local projects"
  for project in ${ACTIVE_PROJECTS[@]}; do
    echo ">>> Updating project: $project"
    pushd $project
    git pull
    popd
  done
  echo ">>> Update config"
  updateMachine.sh;
  echo ">>> Update software"
  paru;
  echo ">>> Update emacs packages"
  emacsclient -e "(auto-package-update-now)"
  emacsclient -e "(straight-pull-all)"
  emacsclient -e "(straight-rebuild-all)"
  echo ">>> Update neovim packages"
  nvim --headless +TSUpdateSync +qa;
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync';
}

setScreenBrightness(){
  xrandr --output DP-0 --brightness $1
}

setKeyboardBrightness(){
  brightnessctl --device='smc::kbd_backlight' set $1
}

updateMirrorList(){
  sudo reflector --latest 100 --protocol https --country 'US' --sort age --save /etc/pacman.d/mirrorlist
}

se(){ 
  du -a $(pwd) | awk '{ gsub (" ", "\\ ", $0); $1 = ""; print $0; }' | fzf | xargs -r xdg-open; 
}

getSinkSource(){ 
  pacmd list-sinks | grep "index" | grep -o "[0-9]*" 
}

pwdclip(){ 
  pwd | awk '{gsub( " ","\\ " ); print}' | xclip -selection c 
}

cdclip(){ 
  $(xclip -o) 
}

updateArchPackages(){ 
  sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort .arch_packages))
}

installArchPackages(){ 
  sudo pacman -S --needed - < .arch_packages 
}

changeVolume(){
  pactl set-sink-volume $(pacmd list-sinks | grep "index" | grep -o "[0-9]*") $1
}

tns(){
  tmux new -s $1 -d
  tmux switch -t $1
}

trs(){
  tmux rename-session $1
}
