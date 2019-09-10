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
        cat "$file" | xargs yum install -y
        yum -y clean all --enablerepo='*'
        rm -rf /var/cache/yum
    else
         echo "$file is empty. Skip"
    fi
done



