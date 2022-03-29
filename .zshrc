#zmodload zsh/zprof 

source $HOME/.config/zsh/prompt.sh
source $HOME/.config/zsh/export.sh
source $HOME/.config/zsh/aliases.sh

#ZSH_THEME="simple"
#plugins=(git)
eval "$(zoxide init zsh)"
eval $(thefuck --alias)

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
LOCAL_ZSH_SCRIPTS=(\
  "$ZSH_SCRIPT_DIR/system.sh" \
  "$ZSH_SCRIPT_DIR/util.sh" \
  "$ZSH_SCRIPT_DIR/backup-scripts.sh" \
  "$ZSH_SCRIPT_DIR/git.sh" \
  "$ZSH_SCRIPT_DIR/install-z3.sh" \
  "$ZSH_SCRIPT_DIR/bosque.sh" \
  "$ZSH_SCRIPT_DIR/ultimate_automizer.sh" \
  "$ZSH_SCRIPT_DIR/theme_changer.sh" \
)

for SCRIPT in ${TO_SOURCE[@]}; do 
  [ -f $SCRIPT ] && source $SCRIPT
done

for SCRIPT in ${LOCAL_ZSH_SCRIPTS[@]}; do 
  [ -f $SCRIPT ] && source $SCRIPT
done

#zprof
