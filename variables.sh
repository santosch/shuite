#!/bin/bash

SHUITE_ROOT="${BASH_SOURCE%/*}"

COLOR_NO='\033[0m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[1;33m'
COLOR_GREEN='\033[0;32m'
COLOR_CYAN='\033[0;36m'
COLOR_BLUE='\033[0;34m'

SHUITE_DEFAULT_PLUGINS=(
  "plugins/composer"
  "plugins/ohmybash"
  "plugins/ssh"
  "plugins/sync"
)

if [[ -z $SHUITE_PLUGIN_LIST ]];
then
  SHUITE_PLUGINS=( "${SHUITE_DEFAULT_PLUGINS[@]}" )
else
  # shellcheck disable=SC2206
  SHUITE_PLUGINS=(${SHUITE_PLUGIN_LIST//,/ })
fi
