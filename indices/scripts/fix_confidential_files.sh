#!/bin/bash
# fixing the confidential datapaths in elitr-testset repo
IFS=$'\n'
for file in ../auto-mt*; do

	for line in $(cat $file); do

		if [[ $line == *"confidential"* ]]; then
			dir_name=$(dirname $line)
			extension=$(echo $line | rev | cut -d. -f1 | rev)
			replacing_with=$(find ../../../${dir_name}/ -name "*.${extension}")
			echo $replacing_with | cut -d/ -f4->> temp_file

		else
			echo -e "$line" >> temp_file
		fi

	done

mv temp_file $file

done

unset IFS
