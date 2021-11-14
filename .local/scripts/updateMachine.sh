alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout master
config pull
branch_name=config rev-parse --abbrev-ref HEAD
config checkout $branch_name
config merge master
