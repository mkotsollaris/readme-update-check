#!/bin/bash
echo Hello "${IGNORED_FILES}"
echo Hello "${DAYS_THRESHOLD}"
find . -type f -name "*.md" | while read mdFile; do
  gitDate=$(git log -1 --pretty="format:%as" $mdFile)
  B=$(date -d $gitDate +'%y%m%d')
  echo $A
  echo $B
  DIFF=$(( ($(date --date=$A +%s) - $(date --date=$B +%s) )/(60*60*24) ))
  echo $mdFile $DIFF
  if [ $DIFF>$DAYS_THRESHOLD ]
    then
        exit 1
  fi
done