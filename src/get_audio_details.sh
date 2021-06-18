#!/bin/bash

for item in ../indices/auto*;
do
	file_save="$(echo $item | rev | cut -d/ -f2- --complement | rev)"
	for line in $(cat $item | grep -E '.mp3$|.mkv$|.aac$|.ogg$');
	do
		audio_file="$(echo $line | grep ^elitr-testset | grep -v mt-pair.sh )"
		file_name="$(echo "$audio_file" | rev | cut -d/ -f2- --complement | rev)"
		length="-------"
		echo $audio_file
		if [[ "$audio_file" == *"link" ]]; then
			#statements
			length="Link_file_insert_manually"
		else
			if [[ "$audio_file" == *".mp3" ]]; then
				length="$(ffmpeg -i ../../${audio_file} 2>&1 | awk '/Duration/ { print substr($2,0,length($2)-1) }')"
			elif [[ "$audio_file" == *".mkv" ]]; then
				length="$(ffmpeg -i ../../${audio_file} 2>&1 | awk '/Duration/ { print substr($2,0,length($2)-1) }')"
			elif [[ "$audio_file" == *".aac" ]]; then
				length="$(ffmpeg -i ../../${audio_file} 2>&1 | awk '/Duration/ { print substr($2,0,length($2)-1) }')"
			elif [[ "$audio_file" == *".ogg" ]]; then
				length="$(ffmpeg -i ../../${audio_file} 2>&1 | awk '/Duration/ { print substr($2,0,length($2)-1) }')"
			fi

		fi
		echo -e "$file_name\t$length" >> ../stats/audio_length/${file_save}
	done
done
