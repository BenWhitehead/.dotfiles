#!/bin/bash

function mkdircd() {
    mkdir $1 && cd $1
}

function hashstring() {
    echo -n $1 | openssl dgst -md5
}

function trim {
    local var=$@
    var="${var#"${var%%[![:space:]]*}"}"   # remove leading whitespace characters
    var="${var%"${var##*[![:space:]]}"}"   # remove trailing whitespace characters
    echo -n "$var"
}

function fmtNum {
  local numDigits=${2:-2}
  printf "%0${numDigits}d" $1
}

function now { date +"%Y-%m-%d %H:%M:%S" | tr -d '\n' ;}
function msg { println "$*" >&2 ;}
function err { local x=$? ; msg "$*" ; return $(( $x == 0 ? 1 : $x )) ;}
function println { printf '%s\n' "$(now) $*" ;}
function print { printf '%s ' "$(now) $*" ;}

function newbashfile {
  cat <<EOF
#!/bin/bash
set -o errexit -o nounset -o pipefail

function main {
  echo main
}

######################### Delegates to subcommands or runs main, as appropriate
if [[ ${1:-} ]] && declare -F | cut -d' ' -f3 | fgrep -qx -- "${1:-}"
then "$@"
else main
fi
EOF
}

