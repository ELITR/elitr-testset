#!/bin/bash
#list all test set files in a directory, grouping them by their names

root_dir=$1
arr=()

if [[ $root_dir == "" ]]; then
	echo "Please enter a path to a directory you want to list"
	exit
fi

for file in `find "$root_dir" -type f | sort | grep -v '\.history-\|README.md' `; do
	group=`echo $file | awk 'BEGIN { FS = "/" } { print $NF }' | cut -d"." -f 1`

	if [[ "$previous_group" != "$group" ]]; then
		for item in "${arr[@]}"; do
	    	echo $item
		done
		echo -e "\n"
		arr=()
	fi

	file=`echo "$file" | sed 's:../../::g'`
	arr+=("$file")
	previous_group=$group
done 
		
#print last group
for item in "${arr[@]}"; do
	echo $item
done
