#!/bin/bash
#list all data that can be used to evaluate asr

files="$1"

for file in $files; do
	group=`echo $file | awk 'BEGIN { FS = "/" } { print $NF }' | cut -d"." -f 1`
	if [[ "$previous_group" != "$group" ]]; then
		echo -e "\n"
	fi
	echo "$file"
	previous_group=$group
done
