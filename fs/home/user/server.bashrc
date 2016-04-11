# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true

export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.xz=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
export LS_OPTIONS='-N --color=tty -T 0'

function _ls () { 
    local IFS=' ';
    command ls $LS_OPTIONS ${1+"$@"}
}

alias ls='_ls'
alias la='ls -la'
alias ll='ls -l'

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'


# File operations
alias filecount='echo "`pwd`: `ls -1R | grep -v "\./" | grep -v "^$" | grep -v "\.:" | wc -l` files for a total of `du -hs`"'
alias filecountall='echo "`pwd`: `ls -1aR | grep -v "\./" | grep -v "^$" | grep -v "\.:" | wc -l` files for a total of `du -hs`"'

# Functions
function findinjar() {
	for jar in `find . -iname \*.jar`; do echo "$jar: "; jar tvf $jar | grep $1; done
}
function mkdircd() {
	mkdir $1; cd $1
}

function hashstring() {
    echo -n $1 | openssl dgst -md5
}

function gcstat() {
    $JAVA_HOME/bin/jstat -gcutil -h 10 $1 5s
}

function heapSummary() {
	$JAVA_HOME/bin/jmap -heap $1
}

function threadDump() {
	$JAVA_HOME/bin/jstack $1; heapSummary $1
}

function httpp() {
	http --pretty=all --print=HhBb $@
}

# Orchestra HTTPIE
export ORCHESTRA_HOST=localhost
export ORCHESTRA_PORT=9610

function loginOrchestraFrontend() {
	http --session=orchestra-frontend --form POST http://$ORCHESTRA_HOST:$ORCHESTRA_PORT/login username=test@mesosphere.io password=test1234
}
function logoutAllOrchestraFrontend() {
	for f in `find ~/.httpie/ -name orchestra-frontend.json`; do rm $f;done
}
function ofhttp() {
	http --session-read-only=orchestra-frontend $@
}
function ofhttpp() {
	ofhttp --pretty=all --print=HhBb $@
}

################################################################################
#
#  PS1 Customization
#
#     default suse PS1: "$(ppwd \l)\u@\h:\w> "
#
################################################################################

#    Colors used in the PS1
#      customization
#
#######################################
# No Color
PS_NC='\[\e[0m\]'
# Normal Weight
PS_BLACK='\[\e[0;30m\]'
PS_RED='\[\e[0;31m\]'
PS_GREEN='\[\e[0;32m\]'
PS_BROWN='\[\e[0;33m\]'
PS_BLUE='\[\e[0;34m\]'
PS_PURPLE='\[\e[0;35m\]'
PS_CYAN='\[\e[0;36m\]'
PS_LIGHTGRAY='\[\e[0;37m\]'
# Bold Colors
PS_DARKGRAY='\[\e[1;30m\]'
PS_LIGHTRED='\[\e[1;31m\]'
PS_LIGHTGREEN='\[\e[1;32m\]'
PS_YELLOW='\[\e[1;33m\]'
PS_LIGHTBLUE='\[\e[1;34m\]'
PS_LIGHTPURPLE='\[\e[1;35m\]'
PS_LIGHTCYAN='\[\e[1;36m\]'
PS_WHITE='\[\e[1;37m\]'

MAIN=$PS_BLUE
OFF=$PS_YELLOW

PS1="$MAIN\h: $OFF\w$MAIN>$PS_NC "

