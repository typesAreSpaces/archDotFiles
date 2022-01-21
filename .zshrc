source $HOME/.config/zsh/export.sh

ZSH_THEME="simple"
plugins=(git)
eval "$(zoxide init zsh)"

# Init
TO_SOURCE=(\
  "$ZSH/oh-my-zsh.sh" \
  "$HOME/.fzf.zsh" \
  "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" \
)
ACTIVE_PROJECTS=(\
  "$PHD_THESIS_DIR" \
  "$LATEX_MACROS_DIR" \
  "$GITHUB_PROJECTS_DIR/QuickTex"
)
for script in ${TO_SOURCE[@]}; do 
  [ -f $script ] && source $script
done

# General Aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sshLocalUbuntuVM="ssh -p 2222 jose@127.0.0.1"
alias sshJose='ssh -X jose@10.88.139.128'
alias dict='sdcv'

# Directory Aliases
alias second_home="cd /media"
alias phd_thesis="cd $PHD_THESIS_DIR"
alias papers_for_thesis="cd $PHD_THESIS_DIR/Documents/Papers"
alias extra="cd $PHD_THESIS_DIR/Documents/Side-Projects/kapur-talks/mpi21"
alias reports="cd $REPORTS_DIR/$CURRENT_REPORT"
alias ta="cd $CURRENT_TA_DIR"
alias thesis="cd $WRITE_UPS_DIR/thesis"
alias personal_notes="cd $WRITE_UPS_DIR/personal_notes"

# Program Aliases
alias open="xdg-open"
alias ocaml="rlwrap ocaml"
alias wolfram="rlwrap wolfram"
alias m2="M2 --script"
alias t="tmux"
alias te="tmux new-session -s work -d;\
  tmux rename-window -t work:1 todo; \
  tmux send-keys -t work:1 \
  emacs\ -nw\ $TODOLIST_DIR/research_tasks.org\ \
  C-m;\
  tmux new-window -t work:2 -n report;\
  tmux send-keys -t work:2 \
  reports C-m; \
  tmux a -t work"
  alias tksp="tmux kill-pane"
  alias tks="tmux kill-session"
  alias tksr="tmux kill-server"
  alias v="vim"
  alias nv="nvim --listen localhost:12345"
  alias nvs="nvim --listen localhost:12345 -S session"
  alias e="emacs -nw"
  alias todo="emacs -nw $PHD_THESIS_DIR/Documents/Org-Files/research_tasks.org"
  alias updatetodos="$SCRIPT_DIR/updateTodoLists.sh"
  alias addref="nvim $PHD_THESIS_DIR/Documents/Write-Ups/references.bib"
  za(){
    zathura $1 &
  }
alias smtinterpol="java -jar $APPS_DIR/smtinterpol-2.5-663-gf15aa217.jar"
alias ccwr="changeCurrentWeeklyReport"

# Docker Aliases
alias seahorn="systemctl start docker && sudo docker run -v $(pwd):/host -it seahorn/seahorn-llvm5"

# Local Scripts

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

removeQuotes(){
  cat $1 | tr -d '"'
}

## Video uploader
upload_video(){
  THUMBNAIL_PATH=$2
  [ -z $THUMBNAIL_PATH ] && THUMBNAIL_PATH=/home/jose/Pictures/thumbnail.jpg
  python $GITHUB_PROJECTS_DIR/VideoUploaderMachine/upload_video.py \
    --file $1 \
    --thumbnail $THUMBNAIL_PATH
  }

## Brightness script
setScreenBrightness(){
  xrandr --output DP-0 --brightness $1
}
## ImageGoNord script
imageGoNord(){
  python $GITHUB_PROJECTS_DIR/ImageGoNord/src/cli.py --img=$1 -o=$2
}

updateMirrorList(){
  sudo reflector --latest 100 --protocol https --country 'US' --sort age --save /etc/pacman.d/mirrorlist
}

## Transport files and directories between SSD and HDD
backup(){
  if [ -f $1 ]; then
    SHARED_LOCAL_DIR=$(echo $(dirname $(readlink -f $1)) | cut -b 7-)
    if [ ! -d /media/$SHARED_LOCAL_DIR ]; then
      mkdir -p /media/$SHARED_LOCAL_DIR
    fi
    mv $1 /media/$SHARED_LOCAL_DIR/$1
  fi
  if [ -d $1 ]; then
    SHARED_LOCAL_DIR=$(echo $(dirname $(realpath $1)) | cut -b 7-)
    if [ ! -d /media/$SHARED_LOCAL_DIR ]; then
      mkdir -p /media/$SHARED_LOCAL_DIR
    fi
    mv $1 /media/$SHARED_LOCAL_DIR
  fi
}
restore(){
  if [ -f $1 ]; then
    SHARED_LOCAL_DIR=$(echo $(dirname $(readlink -f $1)) | cut -b 8-)
    if [ ! -d /home/$SHARED_LOCAL_DIR ]; then
      mkdir -p /home/$SHARED_LOCAL_DIR
    fi
    mv $1 /home/$SHARED_LOCAL_DIR/$1
  fi
  if [ -d $1 ]; then
    SHARED_LOCAL_DIR=$(echo $(dirname $(realpath $1)) | cut -b 8-)
    if [ ! -d /home/$SHARED_LOCAL_DIR ]; then
      mkdir -p /home/$SHARED_LOCAL_DIR
    fi
    mv $1 /home/$SHARED_LOCAL_DIR
  fi
}

## Set bspwm layout
bspLayout(){
  bsp-layout set $1 $2 -- --master-size 0.5
}
alias bsptall1="bspLayout tall 1"

## Quick script for local dot files
quickConfigUpdate(){
  config status | grep "modified:" | sed 's/modified:/git --git-dir=$HOME\/.cfg --work-tree=$HOME add/g' | zsh;
  config status | grep "new file:" | sed 's/new file:/git --git-dir=$HOME\/.cfg --work-tree=$HOME add/g' | zsh;
}
alias qcu="quickConfigUpdate"
quickConfigRestore(){
  config status | grep "modified:" | sed 's/modified:/git --git-dir=$HOME\/.cfg --work-tree=$HOME restore/g' | zsh;
}
quickUntrack(){
  config rm --cached $1
}

## Git scripts
quickGitPush(){
  git add .;
  git commit -m $1;
  git push
}

## Scripts for system management
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

## Scripts to install different versions of Z3
installZ3(){ 
  pushd "$GITHUB_PROJECTS_DIR/z3"; 
  python ./scripts/mk_make.py
  cd ./build;
  sudo make install -j$(nproc);
  popd; 
}
installMyZ3(){ 
  pushd "$GITHUB_PROJECTS_DIR/z3__"; 
  python ./scripts/mk_make.py
  cd ./build;
  sudo make install -j$(nproc);
  popd; 
}
installZ3InterpPlus(){ 
  pushd "$GITHUB_PROJECTS_DIR/z3-interp-plus"; 
  python ./scripts/mk_make.py
  cd ./build;
  sudo make install -j$(nproc);
  popd; 
}

## Bosque project related scripts
bosqueProject(){
  Z3_VER=$(z3 --version);
  RESULT=$(echo $Z3_VER | awk '{ print $3; print "4.7.1"; }' | sort -rV | head -1);
  if [ "$RESULT" = "4.7.1" ]; then
    installZ3;
  fi
  cd $BOSQUE_DIR/impl;
}
bosqueVerifier(){
  tsc -p $BOSQUE_DIR/impl/tsconfig.json;
  node $BOSQUE_DIR/impl/bin/verifier/typescript_files/run_verifier.js $1
}
bosqueOptimizer(){
  tsc -p $BOSQUE_DIR/impl/tsconfig.json;
  node $BOSQUE_DIR/impl/bin/optimizer/run_optimizer.js $1
}
bosqueSymTest(){
  npm run-script build;
  if [ $# -eq 1 ]; then
    node $BOSQUE_DIR/impl/bin/runtimes/symtest/symtest.js $1 -v;
  else
    node $BOSQUE_DIR/impl/bin/runtimes/symtest/symtest.js $1 -v -o $2;
  fi
}

## Ultimate project related scripts
runUltimateAutomizer(){
  # Example
  # runUltimateAutomizer \
  # $GITHUB_PROJECTS_DIR/AXDInterpolator/tests/sv-benchmarks/c/properties/no-overflow.prp \
  # 32bit simple \
  # $GITHUB_PROJECTS_DIR/AXDInterpolator/tests/sv-benchmarks/c/termination-crafted/Collatz.c
  $GITHUB_PROJECTS_DIR/ultimate/releaseScripts/default/UAutomizer-linux/Ultimate.py \
    --spec $1 --architecture $2 precise --file $3
  }
buildUltimateAutomizer() { 
  pushd $GITHUB_PROJECTS_DIR/ultimate/releaseScripts/default
  ./makeFresh.sh
  popd
}

## Edit personal latex symbols: symbols.sty
editSyms(){
  pushd $HOME/texmf/tex/latex/local;
  nv symbols.sty;
  git add symbols.sty;
  git commit -m "Minor changes."; 
  git push;
  popd;
}

## Scripts to customize system

alacrittyThemeSwitch(){
  case $1 in  
    "gruvbox")
      alacritty-theme-switch --select gruvbox_dark.yml
      ;;
    "nord")
      alacritty-theme-switch --select nord.yml
      ;;
    "tokyo")
      alacritty-theme-switch --select tokyo-night.yml
      ;;
  esac
}
polybarThemeSwitch(){
  config_file=$HOME/.config/polybar/config.ini
  case $1 in
    "gruvbox")
      ~/.config/polybar/scripts/colors.sh -gruvbox-dark
      sed -i "s|^border-color.*|border-color = #689d6a|g" $config_file
      ;;
    "nord")
      ~/.config/polybar/scripts/colors.sh -nord
      sed -i "s|^border-color.*|border-color = #88C0D0|g" $config_file
      ;;
    "tokyo")
      ~/.config/polybar/scripts/colors.sh -tomorrow-night
      sed -i "s|^border-color.*|border-color = #7aa2f7|g" $config_file
      ;;
  esac
}
wallpaperThemeSwitch(){
  case $1 in
    "gruvbox")
      sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/mountains.jpg|g" $2
      ;;
    "nord")
      sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/minimal_mountains.png|g" $2
      ;;
    "tokyo")
      sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/city_night_city_coast_179489_3840x2160.jpg|g" $2
      ;;
  esac
}
nvimThemeSwitch(){
  config_file=$HOME/.config/nvim/lua/customization.lua
  case $1 in
    "gruvbox")
      sed -i "s/vim.cmd(\[\[color.*/vim.cmd(\[\[color gruvbox-material\]\])/g" $config_file
      ;;
    "nord")
      sed -i "s/vim.cmd(\[\[color.*/vim.cmd(\[\[color nord\]\])/g" $config_file
      ;;
    "tokyo")
      sed -i "s/vim.cmd(\[\[color.*/vim.cmd(\[\[color tokyonight\]\])/g" $config_file
      ;;
  esac
}
emacsThemeSwitch(){
  emacs_dir=$HOME/.emacs.d
  case $1 in
    "gruvbox")
      sed -i "s/(load-theme.*/(load-theme 'doom-gruvbox t))/g" $emacs_dir/Emacs.org
      sed -i "s/(load-theme.*/(load-theme 'doom-gruvbox t))/g" $emacs_dir/init.el
      ;;
    "nord")
      sed -i "s/(load-theme.*/(load-theme 'doom-nord t))/g" $emacs_dir/Emacs.org
      sed -i "s/(load-theme.*/(load-theme 'doom-nord t))/g" $emacs_dir/init.el
      ;;
    "tokyo")
      sed -i "s/(load-theme.*/(load-theme 'doom-palenight t))/g" $emacs_dir/Emacs.org
      sed -i "s/(load-theme.*/(load-theme 'doom-palenight t))/g" $emacs_dir/init.el
      ;;
  esac
}
bspwmThemeSwitch(){
  config_file=$HOME/.config/bspwm/bspwmrc
  case $1 in
    "gruvbox")
      sed -i "s|.*focused_border_color.*|bspc config focused_border_color \"#689d6a\"|g" $config_file
      ;;
    "nord")
      sed -i "s|.*focused_border_color.*|bspc config focused_border_color \"#88C0D0\"|g" $config_file
      ;;
    "tokyo")
      sed -i "s|.*focused_border_color.*|bspc config focused_border_color \"#7aa2f7\"|g" $config_file
      ;;
  esac
}
zathuraThemeSwitch(){
  case $1 in
    "gruvbox")
      $HOME/.config/zathura/apply-gruvbox.sh
      ;;
    "nord")
      $HOME/.config/zathura/apply-nord.sh
      ;;
    "tokyo")
      $HOME/.config/zathura/apply-tokyo.sh
      ;;
  esac
}

changeTheme(){
  alacrittyThemeSwitch $2
  polybarThemeSwitch $2
  nvimThemeSwitch $2
  emacsThemeSwitch $2
  zathuraThemeSwitch $2
  tmuxThemePicker.sh $2
  case $1 in
    "i3")
      wallpaperThemeSwitch $2 "$HOME/.config/i3/config"
      # TODO check if i3 requires to be restarted
      ;;
    "bspwm")
      wallpaperThemeSwitch $2 "$HOME/.config/bspwm/bspwmrc"
      bspwmThemeSwitch $2
      bspc wm -r
      ;;
  esac 
  echo "Theme has changed to " $2 " for " $1
}

alias bspwmGruvbox="changeTheme bspwm gruvbox"
alias bspwmNord="changeTheme bspwm nord"
alias bspwmTokyo="changeTheme bspwm tokyo"

# OPAM configuration
#. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
#zprof
