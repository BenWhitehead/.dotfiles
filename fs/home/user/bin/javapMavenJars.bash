#!/bin/bash
set -o errexit -o nounset -o pipefail

__SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

M2_REPOSITORY="${M2_REPOSITORY:-$HOME/.m2/repository}"
TMPDIR="${TMPDIR:-$HOME/tmp}"

## Version mapping according to https://javaalmanac.io/bytecode/versions/
function _javap() {
  local className
  className=$1
  javap -verbose "${className}" \
    | grep 'major' \
    | sed 's#version: 48#version: 48 // java4#g' \
    | sed 's#version: 49#version: 49 // java5#g' \
    | sed 's#version: 50#version: 50 // java6#g' \
    | sed 's#version: 51#version: 51 // java7#g' \
    | sed 's#version: 52#version: 52 // java8#g' \
    | sed 's#version: 53#version: 53 // java9#g' \
    | sed 's#version: 54#version: 54 // java10#g' \
    | sed 's#version: 55#version: 55 // java11#g' \
    | sed 's#version: 56#version: 56 // java12#g' \
    | sed 's#version: 57#version: 57 // java13#g' \
    | sed 's#version: 58#version: 58 // java14#g' \
    | sed 's#version: 59#version: 59 // java15#g' \
    | sed 's#version: 60#version: 60 // java16#g' \
    | sed 's#version: 61#version: 61 // java17#g' \
    | sed 's#version: 62#version: 62 // java18#g' \
    | sed 's#version: 63#version: 63 // java19#g' \
    | sed 's#version: 64#version: 64 // java20#g' \
    | sed 's#version: 65#version: 65 // java21#g' \
    | sed 's#version: 66#version: 66 // java22#g' \
    | sed 's#version: 67#version: 67 // java23#g'
}

function _findClassFile() { (
  find ./ -type f -name '*.class' ! -path '*META-INF/versions/*' ! -path '*module-info.class' | sort | awk '(n=gsub(/[^\/]+/,"&"))<m || NR==1{m=n;p=$0} END{print p}'
) }

function main() { (

  local pwd=$(pwd)
  local uri=$1
  local    groupId=$(echo ${1} | sed -E 's/^(.+?):(.+)$/\1/g' | sed -E 's#\.#/#g')
  local artifactId=$(echo ${1} | sed -E 's/^(.+?):(.+)$/\2/g')

  local artifactDir="${M2_REPOSITORY}/${groupId}/${artifactId}"
  local versions=""
  pushd $artifactDir >/dev/null
    versions=$(find ./ -mindepth 1 -maxdepth 1 -type d  | sed 's#^\./##g' | sort -V)
  popd >/dev/null

  for version in ${versions}; do
    msg "$uri:$version"
    local tmpDir="${TMPDIR}/javapMavenJars/${version}"
    mkdir -p ${tmpDir}
#    TODO: Improve file existence checking and handling
    pushd ${tmpDir} >/dev/null
      jarPath="${artifactDir}/${version}/${artifactId}-${version}.jar"
      if [ -f ${jarPath} ]; then
        unzip -u -o ${jarPath} > /dev/null 2>&1
        className="${2:-$(_findClassFile)}"
        msg "  $(_javap ${className})"
      else
        msg "jar file not found for version ${version}, skipping"
      fi
    popd >/dev/null
  done
  rm -rf "${TMPDIR}/javapMavenJars"
) }

function now { date +"%Y-%m-%d %H:%M:%S" | tr -d '\n' ;}
function msg { println "$(now) $*" >&2 ;}
function err { local x=$? ; msg "$*" ; return $(( $x == 0 ? 1 : $x )) ;}
function println { printf '%s\n' "$*" ;}
function print { printf '%s ' "$(now) $*" ;}

if [[ ${1:-} ]] && declare -F | cut -d' ' -f3 | fgrep -qx -- "${1:-}"
then "$@"
else main "$@"
fi

