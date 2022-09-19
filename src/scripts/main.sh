#!/bin/bash
echo Hello "${IGNORED_FILES}"
echo QQ "${DAYS_THRESHOLD}"
find . -type f -name "*.md" | while read mdFile; do
  gitDate=$(git log -1 --pretty="format:%as" $mdFile)
  B=$(date -d $gitDate +'%y%m%d')
  echo $A
  echo $B
  DIFF=$(( ($(date --date=$A +%s) - $(date --date=$B +%s) )/(60*60*24) ))
  echo $mdFile $DIFF
  echo $DIFF>"$DAYS_THRESHOLD"
  if [ $DIFF>90 ]
    then
        echo "File: ${mdFile} has not been upgraded for ${DIFF} days."
        exit 1
  fi
done