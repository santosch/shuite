#!/bin/bash

SHUITE_ROOT="${BASH_SOURCE%/*}"

. "$SHUITE_ROOT/variables.sh"

echo -e "${COLOR_CYAN}"
cat "$SHUITE_ROOT/setup/header.txt"
echo -e "${COLOR_NO}"

# shuite setup
. "$SHUITE_ROOT/setup/shuite.sh"