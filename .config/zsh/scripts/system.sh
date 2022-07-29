update(){
  echo ">>> Update local projects"
  for project url in ${(kv)ACTIVE_PROJECTS}; do
    echo ">>> Updating project: $project"
    [ ! -d $project ] && git clone $url $project
    pushd $project
    git pull
    popd
  done
  echo ">>> Update config"
  updateMachine.sh;
  echo ">>> Update software"
  paru;
  echo ">>> Update emacs packages"
  emacsclient -s jose -a emacs -e "(auto-package-update-now)"
  emacsclient -s jose -a emacs -e "(straight-pull-all)"
  emacsclient -s jose -a emacs -e "(straight-rebuild-all)"
  echo ">>> Update neovim packages"
  nvim --headless +TSUpdateSync +qa;
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync';
  echo ">>> Update Latex macros"
  [ -d $LATEX_MACROS_DIR ] && make -C $LATEX_MACROS_DIR
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
  sudo pacman -Qqe > .arch_packages
}

installArchPackages(){ 
  paru -S --needed - < .arch_packages 
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

_grading(){
  cd $CURRENT_TA_DIR/Assignments/Project-3/Students 
}

grading(){
  tmux rename-session grading
  tmux rename-window -t grading:1 todo
  cd $CURRENT_TA_DIR/Assignments/Project-3/Students 
  tmux new-window -n "evaluation"
  tmux new-window -n "implementation" 
  tmux new-window -n "paper"
}

e(){
  emacs --with-profile=$1
}
et(){
  emacsclient -t -s $1 -a emacs
}
ec(){
  emacsclient -c -s $1 -a emacs
}
ke(){
  emacsclient -s $1 -a emacs -e "(kill-emacs)"
}
re(){
  ke $1
  emacs --with-profile=$1 --daemon &
}
