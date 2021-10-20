# ZSHRC file
export TERM=xterm-256color
export HISTIGNORE='*sudo -S*'
export ZSH="$HOME/.oh-my-zsh"
export NVIM_LISTEN_ADDRESS='/tmp/nvimsocket nvim'

ZSH_THEME="simple"
plugins=(git)

export APPS_DIR="$HOME/Documents/Apps"
export GITHUB_PROJECTS_DIR="$HOME/Documents/GithubProjects"
export BOSQUE_DIR="$GITHUB_PROJECTS_DIR/BosqueLanguage"
export MASTER_THESIS_DIR="$GITHUB_PROJECTS_DIR/master-thesis"
export PHD_THESIS_DIR="$GITHUB_PROJECTS_DIR/phd-thesis"
export MSAT_DIR="$APPS_DIR/mathsat-5.6.5-linux-x86_64"
export WALLPAPERS_DIR="~/Pictures/Wallpapers"

export PATH="/usr/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/.opam/system/bin:$PATH"
export PATH="$HOME/.opam/4.07.0/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/maple2019/bin:$PATH"
export PATH="$APPS_DIR:$PATH"
export PATH="$APPS_DIR/LADR-2009-11A/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH" 
export PATH="$APPS_DIR/Matlab/bin:$PATH"
export PATH="$APPS_DIR/csdp6.2.0linuxx86_64/bin:$PATH";

# Init
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f $HOME/.fzf.zsh ]    && source $HOME/.fzf.zsh

# General Aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sshLocalUbuntuVM="ssh -p 2222 jose@127.0.0.1"

# Directory Aliases
alias second_home="cd /media"

alias thesis="cd $PHD_THESIS_DIR/Documents/Write-Ups/thesis"
alias papers_for_thesis="cd $PHD_THESIS_DIR/Documents/Papers"
alias reports="cd $PHD_THESIS_DIR/Documents/Write-Ups/weekly_reports/Fall-2021/scheiderer_local_global_principle"
alias phd_thesis="cd $PHD_THESIS_DIR"
alias personal_notes="cd $PHD_THESIS_DIR/Documents/Write-Ups/personal_notes"

# Program Aliases
alias open="xdg-open"
alias ocaml="rlwrap ocaml"
alias wolfram="rlwrap wolfram"
alias v="vim"
alias nv="nvim --listen localhost:12345"
alias nvs="nvim --listen localhost:12345 -S session"
alias z="zathura"
alias smtinterpol="java -jar $APPS_DIR/smtinterpol-2.5-663-gf15aa217.jar"

# Docker Aliases
alias seahorn="systemctl start docker && sudo docker run -v $(pwd):/host -it seahorn/seahorn-llvm5"

# Local Scripts
## Brightness script
setScreenBrightness(){
  xrandr --output DP-0 --brightness $1
}
## ImageGoNord script
imageGoNord(){
  python $GITHUB_PROJECTS_DIR/ImageGoNord/src/cli.py --img=$1 -o=$2
}

updateMirrorList(){
  sudo reflector --latest 20 --protocol https --sort age --save /etc/pacman.d/mirrorlist
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

## Quick script for local dot files
quickConfigUpdate(){
  config status | grep "modified:" | sed 's/modified:/git --git-dir=$HOME\/.cfg --work-tree=$HOME add/g' | zsh;
  config status | grep "new file:" | sed 's/new file:/git --git-dir=$HOME\/.cfg --work-tree=$HOME add/g' | zsh;
}
quickConfigRestore(){
  config status | grep "modified:" | sed 's/modified:/git --git-dir=$HOME\/.cfg --work-tree=$HOME restore/g' | zsh;
}

## Git scripts
quickGitPush(){
  git add .;
  git commit -m $1;
  git push
}

fromVimToEmacsBindings(){
  xmodmap ~/.Xmodmap
  xmodmap ~/.XmodmapEmacs
}

fromEmacsToVimBindings(){
  xmodmap ~/.XmodmapEmacs
  xmodmap ~/.Xmodmap
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
  sudo pacman -Qqen > .arch_packages 
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
  # runUltimateAutomizer $GITHUB_PROJECTS_DIR/AXDInterpolator/tests/sv-benchmarks/c/properties/no-overflow.prp 32bit simple $GITHUB_PROJECTS_DIR/AXDInterpolator/tests/sv-benchmarks/c/termination-crafted/Collatz.c
  $GITHUB_PROJECTS_DIR/ultimate/releaseScripts/default/UAutomizer-linux/Ultimate.py --spec $1 --architecture $2 precise --file $3
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
gruvboxThemei3(){
  alacritty-theme-switch --select gruvbox_dark.yml
  ~/.config/polybar/scripts/colors.sh -gruvbox-dark
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/iron_lady.jpg|g" ~/.config/i3/config
  sed -i "s|^color.*|color gruvbox|g" ~/.config/nvim/init.vim
}
nordThemei3(){
  alacritty-theme-switch --select nord.yml
  ~/.config/polybar/scripts/colors.sh -nord
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/minimal_mountains.png|g" ~/.config/i3/config
  sed -i "s|^color.*|color nord|g" ~/.config/nvim/init.vim
}
tokyo_nightThemei3(){
  alacritty-theme-switch --select tokyo-night.yml
  ~/.config/polybar/scripts/colors.sh -tomorrow-night
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/tokyo_night_2.jpg|g" ~/.config/i3/config
  sed -i "s|^color.*|color tokyonight|g" ~/.config/nvim/init.vim
}
gruvboxThemebspwm(){
  alacritty-theme-switch --select gruvbox_dark.yml
  ~/.config/polybar/scripts/colors.sh -gruvbox-dark
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/iron_lady.jpg|g" ~/.config/bspwm/bspwmrc
  sed -i "s|.*focused_border_color.*|bspc config focused_border_color \"#689d6a\"|g" ~/.config/bspwm/bspwmrc
  sed -i "s|colorscheme'.*|colorscheme': 'seoul256',|g" ~/.config/nvim/init.vim
  sed -i "s|^color.*|color gruvbox-material|g" ~/.config/nvim/init.vim
  sed -i "s|^border-color.*|border-color = #689d6a|g" ~/.config/polybar/config.ini
}
nordThemebspwm(){
  alacritty-theme-switch --select nord.yml
  ~/.config/polybar/scripts/colors.sh -nord
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/minimal_mountains.png|g" ~/.config/bspwm/bspwmrc
  sed -i "s|.*focused_border_color.*|bspc config focused_border_color \"#88C0D0\"|g" ~/.config/bspwm/bspwmrc
  sed -i "s|colorscheme'.*|colorscheme': 'nord',|g" ~/.config/nvim/init.vim
  sed -i "s|^color.*|color nord|g" ~/.config/nvim/init.vim
  sed -i "s|^border-color.*|border-color = #88C0D0|g" ~/.config/polybar/config.ini
}
tokyo_nightThemebspwm(){
  alacritty-theme-switch --select tokyo-night.yml
  ~/.config/polybar/scripts/colors.sh -tomorrow-night
  #sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/tokyo_night_2.jpg|g" ~/.config/bspwm/bspwmrc
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/city_night_city_coast_179489_3840x2160.jpg|g" ~/.config/bspwm/bspwmrc
  sed -i "s|.*focused_border_color.*|bspc config focused_border_color \"#7aa2f7\"|g" ~/.config/bspwm/bspwmrc
  sed -i "s|colorscheme'.*|colorscheme': 'tokyonight',|g" ~/.config/nvim/init.vim
  sed -i "s|^color.*|color tokyonight|g" ~/.config/nvim/init.vim 
  sed -i "s|^border-color.*|border-color = #7aa2f7|g" ~/.config/polybar/config.ini
}
# OPAM configuration
#. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
