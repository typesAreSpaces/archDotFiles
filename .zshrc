export ZSH="$HOME/.oh-my-zsh"
export HISTIGNORE='*sudo -S*'
export TERM=xterm-256color
ZSH_THEME="simple"
plugins=(git)

export APPS_DIR="$HOME/Documents/Apps"
export GITHUB_PROJECTS_DIR="$HOME/Documents/GithubProjects"
export BOSQUE_DIR="$GITHUB_PROJECTS_DIR/BosqueLanguage"
export MASTER_THESIS_DIR="$GITHUB_PROJECTS_DIR/master-thesis"
export PHD_THESIS_DIR="$GITHUB_PROJECTS_DIR/phd-thesis"
export MSAT_DIR="$APPS_DIR/mathsat-5.6.5-linux-x86_64"
export WALLPAPERS_DIR="\$HOME/Pictures/Wallpapers"

export PATH="/usr/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opam/system/bin:$PATH"
export PATH="$HOME/.opam/4.07.0/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/maple2020/bin:$PATH"
export PATH="$APPS_DIR:$PATH"
export PATH="$APPS_DIR/LADR-2009-11A/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH" 
export PATH="$APPS_DIR/Matlab/bin:$PATH"
export PATH="$APPS_DIR/csdp6.2.0linuxx86_64/bin:$PATH";

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# General Aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias git_discard_dhanges="git stash save --keep-index --include-untracked"
alias sshVB="ssh -p 2222 jose@127.0.0.1"
alias find_cpp_etags="find . -type f -iname \"*.[chS]p*\" | xargs etags -a"

# Directory Aliases
alias second_home="cd /media"

alias master_thesis="cd $MASTER_THESIS_DIR/Software/Cpp/EUFInterpolant"
alias master_thesis_paper="cd $MASTER_THESIS_DIR/Write\ Ups/thesis"
alias thesis="cd $PHD_THESIS_DIR/Documents/Write\ Ups/thesis"
alias papers_for_thesis="cd $PHD_THESIS_DIR/Documents/Papers"
alias reports="cd $PHD_THESIS_DIR/Documents/Write\ Ups/weekly_reports"

alias bosque_paper="cd $BOSQUE_DIR/Technical\ Reports/Automatic\ verification\ for\ the\ Bosque\ Programming\ Language"

alias prof_kapur="cd $GITHUB_PROJECTS_DIR/Extended-Groebner-Basis"
alias basis_conversion="cd $GITHUB_PROJECTS_DIR/Basis-Conversion"

# Program Aliases
alias open="xdg-open"
alias emacs="emacs -nw"
alias emacs26="emacs26 -nw"
alias ocaml="rlwrap ocaml"
alias wolfram="rlwrap wolfram"
alias v="vim"
alias nv="nvim"
alias smtinterpol="java -jar $APPS_DIR/smtinterpol-2.5-663-gf15aa217.jar"

# Docker Aliases
alias seahorn="systemctl start docker && sudo docker run -v $(pwd):/host -it seahorn/seahorn-llvm5"

# Scripts

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

quickConfigUpdate(){
  config status | grep "modified:" | sed 's/modified:/git --git-dir=$HOME\/.cfg --work-tree=$HOME add/g' | zsh;
  config status | grep "new file:" | sed 's/new file:/git --git-dir=$HOME\/.cfg --work-tree=$HOME add/g' | zsh;
}
quickConfigRestore(){
  config status | grep "modified:" | sed 's/modified:/git --git-dir=$HOME\/.cfg --work-tree=$HOME restore/g' | zsh;
}

se(){ du -a $(pwd) | awk '{ gsub (" ", "\\ ", $0); $1 = ""; print $0; }' | fzf | xargs -r xdg-open; }
getSinkSource(){ pacmd list-sinks | grep "index" | grep -o "[0-9]*" }

pwdclip(){ pwd | awk '{gsub( " ","\\ " ); print}' | xclip -selection c }
cdclip(){ $(xclip -o) }

updateArchPackages(){ sudo pacman -Qqen > .arch_packages }
installArchPackages(){ sudo pacman -S --needed - < .arch_packages }

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

sv-comp-files(){ 
cd $GITHUB_PROJECTS_DIR/AXDInterpolator/tests/sv-benchmarks
}
axdProject(){
  #Z3_VER=$(z3 --version | awk '{ print $3; }');
  #if [ "$Z3_VER" != "4.7.1" ]; then
  #installZ3InterpPlus;
  #fi
  cd $GITHUB_PROJECTS_DIR/AXDInterpolator
}
smtSubmission(){
  cd $GITHUB_PROJECTS_DIR/SMT-2021
}
ultimateProject(){
  cd $GITHUB_PROJECTS_DIR/ultimate/releaseScripts/default/UAutomizer-linux
}
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

eufProject(){
  cd $GITHUB_PROJECTS_DIR/EUFInterpolator
}

myZ3(){
  cd $GITHUB_PROJECTS_DIR/z3-interp-plus
}

editSyms(){
  pushd $HOME/texmf/tex/latex/local;
  nv symbols.sty;
  git add symbols.sty;
  git commit -m "Minor changes."; 
  git push;
  popd;
}

gruvboxThemei3(){
  alacritty-theme-switch --select gruvbox_dark.yml
  ~/.config/polybar/scripts/colors.sh -gruvbox-dark
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/iron_lady.jpg|g" ~/.config/i3/config
  sed -i "s|color.*|color gruvbox|g" ~/.config/nvim/init.vim
}
nordThemei3(){
  alacritty-theme-switch --select nord.yml
  ~/.config/polybar/scripts/colors.sh -nord
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/minimal_mountains.png|g" ~/.config/i3/config
  sed -i "s|color.*|color nord|g" ~/.config/nvim/init.vim
}
tokyo_nightThemei3(){
  alacritty-theme-switch --select tokyo-night.yml
  ~/.config/polybar/scripts/colors.sh -tomorrow-night
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/tokyo_night_2.jpg|g" ~/.config/i3/config
  sed -i "s|color.*|color tokyonight|g" ~/.config/nvim/init.vim
}
gruvboxThemebspwm(){
  alacritty-theme-switch --select gruvbox_dark.yml
  ~/.config/polybar/scripts/colors.sh -gruvbox-dark
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/iron_lady.jpg|g" ~/.config/bspwm/bspwmrc
  sed -i "s|color.*|color gruvbox|g" ~/.config/nvim/init.vim
}
nordThemebspwm(){
  alacritty-theme-switch --select nord.yml
  ~/.config/polybar/scripts/colors.sh -nord
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/minimal_mountains.png|g" ~/.config/bspwm/bspwmrc
  sed -i "s|color.*|color nord|g" ~/.config/nvim/init.vim
}
tokyo_nightThemebspwm(){
  alacritty-theme-switch --select tokyo-night.yml
  ~/.config/polybar/scripts/colors.sh -tomorrow-night
  sed -i "s|$WALLPAPERS_DIR/.*|$WALLPAPERS_DIR/tokyo_night_2.jpg|g" ~/.config/bspwm/bspwmrc
  sed -i "s|color.*|color tokyonight|g" ~/.config/nvim/init.vim
}

# OPAM configuration
#. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
