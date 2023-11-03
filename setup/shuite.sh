#!/bin/bash

function shuite {
  # TODO - from all plugins
  local SCRIPTNAME="$SHUITE_ROOT/functions/$1.sh"

  if test -f "$SCRIPTNAME"
  then
    # this syntax ensures, that the complete script is sub-shelled (so can exit without closing our terminal)
    # but the variables from the variables file can be accessed in every function script
    # shellcheck disable=SC1090
    ( . "$SHUITE_ROOT"/variables.sh && . "$SCRIPTNAME" "${@:2}")
  else
    echo
    echo -e "${COLOR_RED}Command $1 not found!${COLOR_NO}"
    ( . "$SHUITE_ROOT"/variables.sh && . "$SHUITE_ROOT"/functions/help.sh)
  fi
}

# autocompletion based on all functions in the functions directory and then servers in the ssh config
function __shuite_autocomplete {
  local cur opts
  cur="${COMP_WORDS[COMP_CWORD]}"
  case "${COMP_CWORD}" in
    1)
      opts="$(find "$SHUITE_ROOT"/functions -type f | sed -r "s/.+\/(.+)\..+/\1/")"
    ;;
    2)
      # TODO does that make sense here?
      opts="$(__ssh_autocomplete)"
    ;;
  esac
  COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
  return 0
}
complete -F __shuite_autocomplete shuite