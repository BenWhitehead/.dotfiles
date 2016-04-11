#!/bin/bash

function findinjar() {
    for jar in `find . -iname \*.jar`; do echo "$jar: "; jar tvf $jar | grep $1; done
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


