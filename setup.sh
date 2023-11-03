#!/bin/bash

SHUITE_ROOT="${BASH_SOURCE%/*}"

. "$SHUITE_ROOT/variables.sh"

echo -e "${COLOR_CYAN}"
cat "$SHUITE_ROOT/setup/header.txt"
echo -e "${COLOR_NO}"

# shuite setup
. "$SHUITE_ROOT/setup/shuite.sh"

# load plugins
for PLUGIN in "${SHUITE_PLUGINS[@]}";
do
  PLUGIN_PATH="$SHUITE_ROOT/$PLUGIN"
  if [ -d $PLUGIN_PATH ]
  then
    SETUP_PATH="$PLUGIN_PATH/setup.sh"
    if [ -f $SETUP_PATH ]
    then
      echo -e "    - ${COLOR_GREEN}Loading $PLUGIN${COLOR_NO}..."
      . "$SETUP_PATH"
    else
      echo -e "    - ${COLOR_CYAN}Loading $PLUGIN${COLOR_NO}"
    fi
  else
    echo -e "    x ${COLOR_RED}Error loading plugin \"$PLUGIN\"${COLOR_YELLOW} - Folder $PLUGIN_PATH not found${COLOR_NO}"
  fi
done

