#!/bin/bash

IGNORED_FILES=("$IGNORED_FILES")
allFiles=()
erroredFiles=()

find . -type f -name "*.md" | while read mdFile; do

  # appent file to allFiles
  allFiles=(${allFiles[@]} $mdFile) 

  if [[ "${IFS}${IGNORED_FILES[*]}${IFS}" =~ "${IFS}${mdFile}${IFS}" ]];
  then
    # skip if file is in $IGNORED_FILES
    continue
  fi

  gitDate=$(git log -1 --pretty="format:%as" $mdFile)
  B=$(date -d $gitDate +'%y%m%d')
  DIFF=$(( ($(date --date=$A +%s) - $(date --date=$B +%s) )/(60*60*24) ))
  
  if [ $DIFF -gt "$DAYS_THRESHOLD" ];
  then
    erroredFiles+=( $mdFile )
  else
    echo "INFO: $mdFile has not beeing updated in $DIFF days"
  fi
done

if [ ${#erroredFiles[@]} -eq 0 ]; then
  echo "Your documentation is up to date. Good job!"
else
    echo "Oops, something went wrong..."
    echo "These files are not up to date:"
    for i in "${allFiles[@]}"; do echo "$i" ; done
    echo "Consider updating them!"
    exit 1
fi
