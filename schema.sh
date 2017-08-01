#!/bin/bash
#
#Add segments to a list
#
#Validate the segments
#
#Insert non zero exit status for incorrect entries
#
#Will need to research "set"
#
# printf "Examining the following entry...\n"
# printf "$1 \n"
#IN="$1"
#OIFS=$IFS
#IFS='-'
#array=()
#for x in ${IN[@]}
# do
#   echo "> $x" &&
#   arrary+=("$x")
# done
#printf "${array[@]}"
#IFS=$OIFS

IFS='-' read -r -a array <<<"$1"
for element in "${array[@]"
do
  echo "$element"
done

