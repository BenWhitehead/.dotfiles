#!/bin/bash -x

export dir=~/.bash

PATH="/usr/local/bin:$PATH" # for pip3...
PATH="$HOME/bin:$PATH"


for envf in $(ls -1 $dir/env/); do
	source $dir/env/$envf
done

for functionf in $(ls -1 $dir/function/); do
	source $dir/function/$functionf
done

for aliasf in $(ls -1 $dir/alias/); do
	source $dir/alias/$aliasf
done

source $dir/PS1
source $dir/keymap

source /etc/bash_completion
unset dir


