# General aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sshLocalUbuntuVM="ssh -p 2222 jose@127.0.0.1"
alias sshJose='ssh -X jose@10.88.139.128'
alias dict='sdcv'

# Directory aliases
alias second_home="cd /media"
alias phd_thesis="cd $PHD_THESIS_DIR"
alias papers_for_thesis="cd $PHD_THESIS_DIR/Documents/Papers"
alias extra="cd $PHD_THESIS_DIR/Documents/Side-Projects/kapur-talks/mpi21"
alias reports="cd $REPORTS_DIR/$CURRENT_REPORT"
alias ta="cd $CURRENT_TA_DIR"
alias thesis="cd $WRITE_UPS_DIR/thesis"
alias personal_notes="cd $WRITE_UPS_DIR/personal_notes"

# Program aliases
alias open="xdg-open"
alias ocaml="rlwrap ocaml"
alias wolfram="rlwrap wolfram"
alias m2="M2 --script"
alias v="vim"
alias nv="nvim --listen localhost:12345"
alias nvs="nvim --listen localhost:12345 -S session"
alias e="emacs -nw"
alias todo="emacs -nw $PHD_THESIS_DIR/Documents/Org-Files/research_tasks.org"
alias updatetodos="$SCRIPT_DIR/updateTodoLists.sh"
alias addref="nvim $PHD_THESIS_DIR/Documents/Write-Ups/references.bib"
alias smtinterpol="java -jar $APPS_DIR/smtinterpol-2.5-663-gf15aa217.jar"
alias ccwr="changeCurrentWeeklyReport"
alias qcu="quickConfigUpdate"
alias bsptall1="bspLayout tall 1"
alias tksp="tmux kill-pane"
alias tks="tmux kill-session"
alias tksr="tmux kill-server"
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

# Docker aliases
alias seahorn="systemctl start docker && sudo docker run -v $(pwd):/host -it seahorn/seahorn-llvm5"

# Theme changer aliases
alias bspwmGruvbox="changeTheme bspwm gruvbox"
alias bspwmNord="changeTheme bspwm nord"
alias bspwmTokyo="changeTheme bspwm tokyo"