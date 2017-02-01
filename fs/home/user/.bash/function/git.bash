#!/bin/bash

function gitAuthorLineCount() {
  git ls-tree --name-only -r HEAD | xargs -n1 git blame --line-porcelain | grep "^author " | sort | uniq -c | sort -nr
}

function gitAuthorLineCountFilterExtension() {
  git ls-tree --name-only -r HEAD | grep -E "\.($1)$" | xargs -n1 git blame --line-porcelain | grep "^author " | sort | uniq -c | sort -nr
}

# find current files with most commits, including renames
# Found on: http://stackoverflow.com/a/20808251
function gitCountRevisionsPerFile() {(

  git ls-files |
    while read aa
    do
      printf . >&2
      set $(git log --follow --oneline "$aa" | wc)
      printf '%s\t%s\n' $1 "$aa"
    done > bb

  echo
  sort -nr bb
  rm bb

)}
