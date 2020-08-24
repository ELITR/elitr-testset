#!/bin/bash
#list all test set files in a directory, gourping them by their names

root_dir=$1

if [[ $root_dir == "" ]]; then
	echo "Please enter a path to a directory you want to list"
	exit
fi

for file in `find "$(cd $root_dir; pwd)" -type f -not -name "README.md" | sort`; do
	group=`echo $file | awk 'BEGIN { FS = "/" } { print $NF }' | cut -d"." -f 1`

	if [[ "$previous_group" != "$group" ]]; then
		echo -e "\n"
	fi
	echo "$file"
	previous_group=$group
done 
