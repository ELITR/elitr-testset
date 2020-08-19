#!/bin/bash

root_dir='../documents/iwslt2020-nonnative-slt/devset/'

for file in `find "$(cd $root_dir; pwd)" -type f -not -name "README.md" | sort`; do
	group=`echo $file | awk 'BEGIN { FS = "/" } { print $NF }' | cut -d"." -f 1`

	if [[ "$previous_group" != "$group" ]]; then
		echo -e "\n"
	fi
	echo "$file"
	previous_group=$group
done 
