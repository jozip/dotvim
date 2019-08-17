#!/bin/sh

NAME=$1
git submodule deinit pack/stuff/start/$NAME
git rm pack/stuff/start/$NAME
rm -Rf .git/modules/pack/stuff/start/$NAME
git commit -m "Removed $NAME"
