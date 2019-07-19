#!/bin/bash
set -e
if [ "$#" -lt 1 ]
then
echo  "Please insert at least one argument"
exit
else
echo -e "\c"
fi

for file in "$@"
do
    if [ -s  "$file" ]
    then
         pip install -r "$file" --no-cache-dir
    else
         echo "$file is empty. Skip"
    fi
done