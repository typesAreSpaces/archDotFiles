export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(git)

APPS_DIR="$HOME/Documents/Apps"
GITHUB_PROJECTS_DIR="$HOME/Documents/GithubProjects"
BOSQUE_DIR="$GITHUB_PROJECTS_DIR/BosqueLanguage"
MASTER_THESIS_DIR="$GITHUB_PROJECTS_DIR/master-thesis"
PHD_THESIS_DIR="$GITHUB_PROJECTS_DIR/phd-thesis"

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

export MSAT_DIR="$APPS_DIR/mathsat-5.6.5-linux-x86_64"

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# general aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias gitDiscardChanges="git stash save --keep-index --include-untracked"

alias findCPPETAGS="find . -type f -iname \"*.[chS]p*\" | xargs etags -a"

# directory aliases
alias second_home="cd /media/jose/4486d9bd-d3c3-4b92-9842-d38226a22c20$HOME"

alias master_thesis="cd $MASTER_THESIS_DIR/Software/Cpp/EUFInterpolant"
alias master_thesis_paper="cd $MASTER_THESIS_DIR/Write\ Ups/thesis"
alias thesis="cd $PHD_THESIS_DIR/Documents/Write\ Ups/thesis"
alias papers_for_thesis="cd $PHD_THESIS_DIR/Documents/Papers"
alias reports="cd $PHD_THESIS_DIR/Documents/Write\ Ups/weekly_reports"

alias z3_dir="cd $GITHUB_PROJECTS_DIR/z3"
alias my_z3_dir="cd $GITHUB_PROJECTS_DIR/z3__"

alias bosqueProject="cd $BOSQUE_DIR/impl"
alias bosquePaper="cd $BOSQUE_DIR/Technical\ Reports/Automatic\ verification\ for\ the\ Bosque\ Programming\ Language"

alias profKapur="cd $GITHUB_PROJECTS_DIR/Extended-Groebner-Basis"
alias basisConversion="cd $GITHUB_PROJECTS_DIR/Basis-Conversion"

alias axd="cd $GITHUB_PROJECTS_DIR/AXDInterpolator"

alias gitProjects="cd $GITHUB_PROJECTS_DIR"

# program aliases
alias open="xdg-open"
alias emacs="emacs -nw"
alias emacs26="emacs26 -nw"
alias ocaml="rlwrap ocaml"
alias wolfram="rlwrap wolfram"
alias v="vim"
alias nv="nvim"
alias smtinterpol="java -jar $APPS_DIR/smtinterpol.jar"

# scripts
se(){ du -a $HOME/* | awk '{ gsub (" ", "\\ ", $0); $1 = ""; print $0; }' | fzf | xargs -r xdg-open; }
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

edit_syms(){
  pushd $HOME/texmf/tex/latex/local;
  nv symbols.sty;
  git add symbols.sty;
  git commit -m "Minor changes."; 
  git push;
  popd;
}

# OPAM configuration
#. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
