#!/bin/zsh
DOCUMENTS_DIR=$HOME/Documents/GithubProjects/phd-thesis/Documents
pushd $DOCUMENTS_DIR/Org-Files
git add *.org
popd

pushd $DOCUMENTS_DIR/Semesters/Spring/2022/TA-CS-429-529/Org-Files
git add *.org
popd

git commit -m "Update Org-Files."
