#!/bin/bash
# function contains {
#     [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && exit(0) || exit(1)
# }

contains () { echo "hello!" }

echo "$IGNORED_FILES"
echo "$DAYS_THRESHOLD"
erroredFiles=()
find . -type f -name "*.md" | while read mdFile; do
  # check if mdFile is part of IGNORED_FILES
  shouldContinue=contains "$IGNORED_FILES" $mdFile
  echo $shouldContinue
  if [ $DIFF -eq 1 ]
  then
    continue
  fi
  gitDate=$(git log -1 --pretty="format:%as" $mdFile)
  B=$(date -d $gitDate +'%y%m%d')
  echo $A
  echo $B
  DIFF=$(( ($(date --date=$A +%s) - $(date --date=$B +%s) )/(60*60*24) ))
  echo $mdFile $DIFF
  echo $DIFF>"$DAYS_THRESHOLD"

  if [ $DIFF -gt "$DAYS_THRESHOLD" ];
  then
    erroredFiles+=( $mdFile )
  fi

  if [ ${#erroredFiles[@]} -eq 0 ]; 
  then
    echo "Your documentation is up to date. Good job!"
  else
      echo "Oops, something went wrong..."
      echo "These files are not up to date: ${erroredFiles}. Consider updating them!"
      exit 1
  fi
done