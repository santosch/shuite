#!/bin/bash

echo -e "${COLOR_CYAN}Checking ssh-config...${COLOR_NO}"
if [ -f ~/.ssh/config ]
then
  echo -e "${COLOR_RED}-- config already present in ~/.ssh/config! - Aborting!${COLOR_NO}"
  echo -e "${COLOR_YELLOW}-- backup and delete/move it before regenerating!${COLOR_NO}"
else
  echo -e "${COLOR_GREEN}-- no ssh-config found - creating one for you... ${COLOR_NO}"
  mkdir -p ~/.ssh
  read -p "-- Enter your server username (Leave empty to skip). This is usually <firstname.lastname>: " configUsername
  if [[ $configUsername != "" ]];
  then
    cat "$SHUITE_ROOT/plugins/ssh/dist/sshConfig.dist" | sed "s/{{user}}/$configUsername/" >> ~/.ssh/config
    echo -e "${COLOR_GREEN}-- config created!${COLOR_NO}"
    echo
    echo -e "${COLOR_CYAN}-- Fixing ssh config permissions...${COLOR_NO}"
    chmod 600 ~/.ssh/config || true
  else
    echo -e "${COLOR_RED}-- no ssh-config created, since no username was entered... ${COLOR_NO}"
  fi
fi
echo