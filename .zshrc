export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(git)

export PATH="/usr/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opam/system/bin:$PATH"
export PATH="$HOME/.opam/4.07.0/bin:$PATH"
export PATH="$HOME/Documents/GithubProjects/cool-retro-term:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/maple2020/bin:$PATH"
export PATH="$HOME/Documents/Apps:$PATH"
export PATH="$HOME/Documents/Apps/LADR-2009-11A/bin:$PATH"

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# general aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias gitDiscardChanges="git stash save --keep-index --include-untracked"

alias findCPPETAGS="find . -type f -iname \"*.[chS]p*\" | xargs etags -a"

alias gg="npm run-script verifier"
alias tt="npm run-script optimizer"

# directory aliases
alias second_home="cd /media/jose/4486d9bd-d3c3-4b92-9842-d38226a22c20$HOME"

alias semester="cd $HOME/Documents/Current-Semester/PhD\ in\ Computer\ Science\ UNM/Semester\ 3"

alias masterThesis="cd $HOME/Documents/GithubProjects/master-thesis/Software/Cpp/EUFInterpolant"
alias masterThesisPaperProject="cd $HOME/Documents/GithubProjects/master-thesis/Write\ Ups/paper_project"
alias thesis="cd /home/jose/Documents/GithubProjects/master-thesis/Write\ Ups/thesis"

alias z3_dir="cd $HOME/Documents/GithubProjects/z3"
alias my_z3_dir="cd $HOME/Documents/GithubProjects/z3__"

alias bosqueProject="cd $HOME/Documents/GithubProjects/BosqueLanguage/impl"
alias bosquePaper="cd $HOME/Documents/GithubProjects/BosqueLanguage/Technical\ Reports/Automatic\ verification\ for\ the\ Bosque\ Programming\ Language"
alias profKapur="cd $HOME/Documents/GithubProjects/Extended-Groebner-Basis"
alias basisConversion="cd $HOME/Documents/GithubProjects/Basis-Conversion"

alias axd="cd $HOME/Documents/GithubProjects/AXDInterpolator"

# program aliases
alias open="xdg-open"
alias emacs="emacs -nw"
alias emacs26="emacs26 -nw"
alias utop="rlwrap ocaml"
alias v="vim"
alias nv="nvim"
alias smtinterpol="java -jar $HOME/Documents/Apps/smtinterpol.jar"

# scripts
dotfilesChanges() { config status | grep "modified" | grep -v "opam" }
se() { du -a $HOME/* | awk '{ gsub (" ", "\\ ", $0); $1 = ""; print $0; }' | fzf | xargs -r xdg-open; }

pwdclip() { pwd | awk '{gsub( " ","\\ " ); print}' | xclip -selection c }
cdclip() { cd $(xclip -o) }

updateArchPackages() { sudo pacman -Qqen > .arch_packages }
installArchPackages() { sudo pacman -S --needed - < .arch_packages }

installZ3() { pushd "/home/jose/Documents/GithubProjects/z3/build" && sudo make install && popd; }
installMyZ3() { pushd "/home/jose/Documents/GithubProjects/z3__/build" && sudo make install && popd; }
installZ3InterpPlus() { pushd "/home/jose/Documents/GithubProjects/z3-interp-plus/build" && sudo make install && popd; }

# OPAM configuration
#. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

 #opam configuration
#test -r /home/jose/.opam/opam-init/init.zsh && . /home/jose/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
