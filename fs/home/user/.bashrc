#!/bin/bash -x

export dir=~/.bash

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

unset dir


#if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
#    tmux a || tmux
#fi

