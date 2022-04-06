update(){
  for project in ${ACTIVE_PROJECTS[@]}; do
    echo "Updating project: $project"
    pushd $project
    git pull
    popd
  done
  updateMachine.sh;
  paru;
}

setScreenBrightness(){
  xrandr --output DP-0 --brightness $1
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

tss(){
  tmux new -s $1 -d
  tmux switch -t $1
}
