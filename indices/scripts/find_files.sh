#!/bin/bash
#list all test set files in a directory, grouping them by their names

root_dir=$1

if [[ $root_dir == "" ]]; then
	echo "Please enter a path to a directory you want to list"
	exit
fi

for file in `find "$root_dir" -type f -not -name "README.md" | sort`; do
	group=`echo $file | awk 'BEGIN { FS = "/" } { print $NF }' | cut -d"." -f 1`

	if [[ "$previous_group" != "$group" ]]; then
		echo -e "\n"
	fi
	echo "$file" | sed 's:../../::g'
	previous_group=$group
done 
