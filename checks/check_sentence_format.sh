#!/bin/bash

#verify sentence format if files - there should be one sentence per line.
#sentences start with uppercase and end with . ? or !

cd "${0%/*}/.."
root_dir='./documents/iwslt2020-nonnative-slt/devset'
file="$root_dir/antrecorp-01_teddy.OSt"
i=1

while read line; do

	#each sentence should start with a capital letter
  uppercase=`echo "${line^}"`
	if [[ $line != $uppercase ]]; then
		echo "Warning; Line $i in file $file does not begin in uppercase."
	fi

	#each sentence should end with . ! ? or ...
	last_char=`echo $line | tail -c 2` #last char in newline
  if [[ $last_char != "." && $last_char != "?" && $last_char != "!" ]]; then
		echo "Warning: Line $i in file $file does not end with . ! ? or ..."
	fi

	#two sentences per line -> contains pattern "[!?.] [A-Z]"
	line_length=${#line}
	for j in $(seq 0 $line_length); do
		is_terminal=`echo ${line:j:1}`
    if [[ "$is_terminal" =~ [.!?] && ${line:$((j + 1)):1} == " " && ${line:$((j + 2)):1} =~ [A-Z] ]]; then
			echo "Warning: Line $i in file $file contains two or more sentences."
		fi
	done

	i=$((i+1))
done < "$file"
