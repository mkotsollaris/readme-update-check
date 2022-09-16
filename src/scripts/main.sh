#!/bin/bash

find . -type f -name "*.md" | while read mdFile; do
  A=$(date -r $mdFile +'%Y-%d-%m');
  B=$(date +'%Y-%d-%m');
  echo $(date -jf %Y-%d-%m $A +%s)
  echo $(date -jf %Y-%d-%m $B +%s)
  DIFF=$((($(date -jf %Y-%d-%m "$B" +%s) - $(date -jf %Y-%d-%m "$A" +%s))/86400))
  echo $mdFile $DIFF
  if [ $DIFF>60 ]
    then
        exit 1
    fi
done