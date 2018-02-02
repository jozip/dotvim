#!/bin/sh

PATH=$1
NAME=$(basename $PATH)

git submodule add https://github.com/$PATH.git pack/stuff/start/$NAME
git commit
