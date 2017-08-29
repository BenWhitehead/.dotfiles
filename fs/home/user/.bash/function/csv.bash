#!/bin/bash

function csvToTsv {
  awk '{$1=$1}1' FPAT="([^,]+)|(\"[^\"]+\")" OFS='\t' $1
}

function readcsv {
  column -t -s ',' ${@} | less -S -# 10
}

function readtsv {
  column -t -s $'\t' ${@} | less -S -# 10
}

