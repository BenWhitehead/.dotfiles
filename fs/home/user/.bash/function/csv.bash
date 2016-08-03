#!/bin/bash

function csvToTsv {
  awk '{$1=$1}1' FPAT="([^,]+)|(\"[^\"]+\")" OFS='\t' $1
}

function readcsv {
  column -t -s ',' ${1} | less -S -# 10
}

function readtsv {
  column -t -s $'\t' ${1} | less -S -# 10
}

