#!/bin/bash

#alias unzip='jar xf'

alias java8='JAVA_HOME=$JAVA_8_HOME $JAVA_8_HOME/bin/java'

# Inspired by https://stackoverflow.com/a/40754792
function __activateJavaHome() {
  local dir=$1
  if [ -d "$dir" ]; then
    export JAVA_HOME="$dir" && \
    echo "JAVA_HOME=$JAVA_HOME" && \
    $JAVA_HOME/bin/java -version
  else
    echo "Specified JAVA_HOME directory '$dir' is not a directory."
    return 1
  fi
}

alias  j8='__activateJavaHome $JAVA_8_HOME'
alias j11='__activateJavaHome $JAVA_11_HOME'
alias j17='__activateJavaHome $JAVA_17_HOME'
alias j19='__activateJavaHome $JAVA_19_HOME'
alias j20='__activateJavaHome $JAVA_20_HOME'
alias j21='__activateJavaHome $JAVA_21_HOME'

