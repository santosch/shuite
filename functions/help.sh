#!/bin/bash

COLORIZE_COMMAND="s/\`.*\`/"$'\033\[94m&\033\[0m/g'
COLORIZE_HEADLINE="s/#.*#/"$'\033\[36m&\033\[0m/g'

echo
cat "$SHUITE_ROOT/USAGE.md" | sed $COLORIZE_COMMAND | sed $COLORIZE_HEADLINE
echo
echo

# load plugins
for PLUGIN in "${SHUITE_PLUGINS[@]}";
do
  USAGE_PATH="$SHUITE_ROOT/$PLUGIN/USAGE.md"
  if [ -f $USAGE_PATH ]
  then
    cat "$USAGE_PATH" | sed $COLORIZE_COMMAND | sed $COLORIZE_HEADLINE
    echo
    echo
  fi
done
