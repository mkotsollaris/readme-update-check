#!/bin/bash

find . -type f -name "*.md" | while read mdFile; do
  A=$(git log -1 --pretty="format:%as" $mdFile +'%y%m%d')
  B=$(date +'%y%m%d')
  echo $A
  echo $B
  DIFF=$(( ($(date --date=$B +%s) - $(date --date=$A +%s) )/(60*60*24) ))
  echo $mdFile $DIFF
  # if [ $DIFF>60 ]
  #   then
  #       exit 1
  #   fi
done