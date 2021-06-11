#!/bin/bash
IFS=$'\n'

for item in ../indices/auto-mt*;
do
	index_name=$(basename $item)
	for file_name in $(cat $item |  grep -Ev "^#");
	do

		# This if-else condition is unnecessary, but just putting it out so that even if some index *erroneously* contains audio files
		if [[ "$file_name" == *".link" ]] || [[ "$file_name" == *".mp3" ]] || [[ "$file_name" == *".mkv" ]] || [[ "$file_name" == *".aac" ]]; then
			echo -e "upsupported file\t${file_name}">>../stats/${index_name}.err
		else
			echo -e "$(echo $(wc -l -w ../../${file_name}) | sed -e 's/ /\t/g')">> ../stats/${index_name}.tsv
		fi
	done
done
unset IFS
