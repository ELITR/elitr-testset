#!/bin/bash
IFS=$'\n'

extn_to_ignore=()

for item in ../indices/auto-*;
do
	index_name=$(basename $item)
	echo -e "Lines\tWords\tFile_name"> ../stats/text_details/${index_name}.tsv
	for file_name in $(cat $item |  grep -Ev "^#|*.ass|*.align|*.json|*.eaf");
	do

		# This if-else condition is unnecessary, but just putting it here so that even if some index *erroneously* contains audio files
		if [[ "$file_name" == *".link" ]] || [[ "$file_name" == *".mp3" ]] || [[ "$file_name" == *".mkv" ]] || [[ "$file_name" == *".aac" ]] || [[ "$file_name" == *".ogg" ]]; then
			echo -e "upsupported file\t${file_name}">>../stats/text_details/${index_name}.err
		else
			echo -e "$(echo $(wc -l -w ../../${file_name}) | sed -e 's/^[[:space:]]*//g' | sed 's/ \+/\t/g')">> ../stats/text_details/${index_name}.tsv
		fi
	done
done
unset IFS