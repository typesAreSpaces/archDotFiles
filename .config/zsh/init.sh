eval "$(zoxide init zsh)"
eval $(thefuck --alias)

TO_SOURCE=(\
  "$ZSH/oh-my-zsh.sh" \
  "$HOME/.fzf.zsh" \
  "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" \
)
declare -A ACTIVE_PROJECTS
ACTIVE_PROJECTS=( )
ACTIVE_PROJECTS+=( ["$PHD_THESIS_DIR"]="$GITHUB_ACCOUNT_URL/phd-thesis" )
ACTIVE_PROJECTS+=( ["$LATEX_MACROS_DIR"]="$GITHUB_ACCOUNT_URL/PersonalLatexMacros" )
ACTIVE_PROJECTS+=( ["$GITHUB_PROJECTS_DIR/QuickTex"]="$GITHUB_ACCOUNT_URL/QuickTex" )
ACTIVE_PROJECTS+=( ["$GITHUB_PROJECTS_DIR/starter-hugo-academic"]="$GITHUB_ACCOUNT_URL/starter-hugo-academic" )
ACTIVE_PROJECTS+=( ["$PHD_THESIS_DIR/Documents/Semesters/Fall/2022/TA-CS-241/Assignments"]="$GITHUB_ACCOUNT_URL/cs-241-grading" )
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
