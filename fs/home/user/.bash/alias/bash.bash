#!/bin/bash

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'

alias l='ls -l'

alias unzipall='for z in *.zip; do unzip $z;done'

# File operations
alias filecount='echo "`pwd`: `ls -1R | grep -v "\./" | grep -v "^$" | grep -v "\.:" | wc -l` files for a total of `du -hs`"'
alias filecountall='echo "`pwd`: `ls -1aR | grep -v "\./" | grep -v "^$" | grep -v "\.:" | wc -l` files for a total of `du -hs`"'

alias esl='env | sort | less'

