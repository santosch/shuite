#!/bin/bash


echo -e "${COLOR_CYAN}Installing OhMyBash to ~/.oh-my-bash...${COLOR_NO}"
if [ -d ~/.oh-my-bash ]
then
  echo -e "${COLOR_YELLOW}---- already cloned, pulling...${COLOR_NO}"
  cd ~/.oh-my-bash || exit 1
  git pull
else
  echo -e "${COLOR_BLUE}---- cloning...${COLOR_NO}"
  cd ~ || exit 1
  git clone --depth=1 https://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash || exit 1
fi
echo
echo -e "${COLOR_CYAN}Copying config...${COLOR_NO}"
if [ -f ~/.bashrc.ohmybash ]
then
  echo -e "${COLOR_YELLOW}-- already present: ~/.bashrc.ohmybash! Skipping...${COLOR_NO}"
else
  echo -e "${COLOR_BLUE}-- Copying...${COLOR_NO}"
  cp -v "$SHUITE_ROOT/dist/.bashrc.ohmybash" ~
fi
echo
echo -e "${COLOR_BLUE}Adding to .bashrc...${COLOR_NO}"
if ! grep -q ohmybash ~/.bashrc;
then
  echo -e "\n# add ohmybash... .\n. ~/.bashrc.ohmybash" >> ~/.bashrc
else
  echo -e "${COLOR_YELLOW}-- already installed!${COLOR_NO}"
fi
echo
echo
echo -e "${COLOR_GREEN}Success! Reload bash now with${COLOR_NO}"
echo -e "${COLOR_CYAN}\"exec bash\"${COLOR_NO}"
echo
