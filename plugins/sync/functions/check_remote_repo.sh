#!/bin/bash

SHUITE_SYNC_DIR=${PWD##*/}

# this command will be used to check for unpushed changes remote and locally
SHUITE_GIT_DIFF_COMMAND="git status -s && echo && git log --branches --not --remotes --decorate --pretty=format:\"%D%n%<(20)%h%s%n\""

if [ -z "$1" ]
then
  echo -e "${COLOR_RED}No server given. Exiting...${COLOR_NO}"
  exit 1
fi

# check for changed files and unpushed commits on the remote and locally
REMOTE_CHANGES="$(ssh "$1" "cd ~/projects/$SHUITE_SYNC_DIR && $SHUITE_GIT_DIFF_COMMAND")"
LOCAL_CHANGES=$(eval "$SHUITE_GIT_DIFF_COMMAND")

# diff the changes, show only changes and unpushed commits that exist on the remote but not locally
REMOTE_MISSING_CHANGES=$(diff --unchanged-line-format= --old-line-format= --new-line-format='%L' <( echo "$LOCAL_CHANGES" ) <( echo "$REMOTE_CHANGES" ))

echo
if [ -z "$REMOTE_MISSING_CHANGES" ]
then
    echo -e "${COLOR_GREEN}No unpushed changes detected on remote root repository. You should be good to go.${COLOR_NO}"
else
    echo -e "${COLOR_RED}#################################### W A R N I N G ###############################################${COLOR_NO}"
    echo -e "${COLOR_RED}#                                                                                                #${COLOR_NO}"
    echo -e "${COLOR_RED}#   ${COLOR_YELLOW}Remote repository has unpushed commits or uncommited changes that are not present locally.   ${COLOR_RED}#${COLOR_NO}"
    echo -e "${COLOR_RED}#   ${COLOR_YELLOW}These would be OVERWRITTEN by a sync!                                                        ${COLOR_RED}#${COLOR_NO}"
    echo -e "${COLOR_RED}#                                                                                                #${COLOR_NO}"
    echo -e "${COLOR_RED}##################################################################################################${COLOR_NO}"
    echo
    echo -e "${COLOR_YELLOW}"
    echo -e "$REMOTE_MISSING_CHANGES"
    echo -e "${COLOR_NO}"
    exit 1
fi
