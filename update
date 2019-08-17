#!/bin/sh

MESSAGE=$(mktemp -p /tmp dotvimXXXX)
git submodule update --remote --merge
echo "Updated submodules" > $MESSAGE
echo >> $MESSAGE
git status -s | awk '{print $2}' | sed -e 's%pack/stuff/start/%%' >> $MESSAGE
git commit -a -F $MESSAGE
