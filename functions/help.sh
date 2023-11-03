#!/bin/bash

echo
cat "$SHUITE_ROOT/USAGE.md" | sed "s/\`.*\`/"$'\033\[94m&\033\[0m/g'
echo
