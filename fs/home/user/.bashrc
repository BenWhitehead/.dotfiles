#!/bin/bash -x

export dir=~/.bash

PATH=""
PATH="$PATH:$HOME/bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/bin"
PATH="$PATH:/bin"
PATH="$PATH:/usr/bin/X11"
PATH="$PATH:/usr/X11R6/bin"
PATH="$PATH:/usr/games"


for envf in $(ls -1 $dir/env/); do
	source $dir/env/$envf
done

for aliasf in $(ls -1 $dir/alias/); do
	source $dir/alias/$aliasf
done

for functionf in $(ls -1 $dir/function/); do
	source $dir/function/$functionf
done

source $dir/PS1
source $dir/keymap

unset dir
