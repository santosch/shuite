#!/bin/bash

RETURN=1

SHUITE_SYNC_DIR=${PWD##*/}

if [ -z "$1" ]
then
  echo -e "${COLOR_RED}No server given. Exiting...${COLOR_NO}"
  exit 1
fi

if [ -f .rsyncignore ]
then
  rsync -avz --progress --delete --exclude-from ".rsyncignore" . "$1":~/projects/"$SHUITE_SYNC_DIR"
  RETURN=$?
  echo
  if [ $RETURN -eq 0 ]
  then
    echo -e "${COLOR_GREEN}Sync successful.${COLOR_NO}"
  else
    echo -e "${COLOR_RED}Sync failed!${COLOR_NO}"
  fi
  echo
else
	echo "${COLOR_RED}Failed to sync $SHUITE_SYNC_DIR. No .rsyncignore present!${COLOR_NO}"
fi

exit $RETURN
