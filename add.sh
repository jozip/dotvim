#!/bin/sh

NAME=$(basename $1)
git submodule add https://github.com/$1.git pack/stuff/start/$NAME
git commit -m "Added $NAME"
