#!/bin/bash

echo "$IGNORED_FILES"
echo "$DAYS_THRESHOLD"
IGNORED_FILES=("$IGNORED_FILES")
erroredFiles=()
find . -type f -name "*.md" | while read mdFile; do
  # check if mdFile is part of IGNORED_FILES
  # removing the first ./ folder as this is CircleCi directory
  modifiedMdFile="${mdFile}"
  if [[ "${IFS}${IGNORED_FILES[*]}${IFS}" =~ "${IFS}${modifiedMdFile}${IFS}" ]]; then
    echo "true"
    continue
  else
    echo "false"
  fi
  echo "sinexisa"
  gitDate=$(git log -1 --pretty="format:%as" $mdFile)
  B=$(date -d $gitDate +'%y%m%d')
  DIFF=$(( ($(date --date=$A +%s) - $(date --date=$B +%s) )/(60*60*24) ))
  echo "$mdFile has not beeing updated in $DIFF days"

  if [ $DIFF -gt "$DAYS_THRESHOLD" ];
  then
    erroredFiles+=( $mdFile )
  fi
done

 if [ ${#erroredFiles[@]} -eq 0 ]; then
    echo "Your documentation is up to date. Good job!"
  else
      echo "Oops, something went wrong..."
      echo "These files are not up to date: ${erroredFiles}. Consider updating them!"
      exit 1
  fi