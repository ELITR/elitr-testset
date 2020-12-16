#!/bin/bash
# source bashelan.sh
source common.sh
echo "Cleaning the directory and copying new files"
mkdir -p ../../../SLTev/SLTev-cache/OStt-tt-files/
rm -rf ../../../SLTev/SLTev-cache/OStt-tt-files/*

# Copying the files

for line in $(cat $1)
do
	# echo "$line"
	if [[ "$line" == *".link"* ]];
	then
		file=`cat ../../$line`
	else
		file=`realpath ../../"$line"`
	fi

	cp $file ../../../SLTev/SLTev-cache/OStt-tt-files/
done


# Converting files into 16K format files, TODO:

for i in $(find ../../../SLTev/SLTev-cache/OStt-tt-files/ -type f -name "*.mp3");
do
	temp_name=$(basename $i)
    file_name=$(basename "$temp_name" | rev | cut -d. -f2- | rev)
    dir_name=$(dirname $i)
    op_wav="$dir_name/${file_name}_16K.wav"
	ffmpeg -hide_banner -loglevel panic -y -i $i -acodec pcm_s16le -ar 16000 -ac 1 $op_wav
done

# Processing ASR of files

FROMASR=$2
index_name=$(basename $1)

CLIENT="./ebclient -s $MEDIATOR -p 4448 --timestamps -r"
for i in $(find ../../../SLTev/SLTev-cache/OStt-tt-files/ -type f -name "*_16K.wav");
do
	temp_name=$(basename $i)
    file_name=$(basename "$temp_name" | rev | cut -d. -f2- | rev)
	LOGSPATH=$(git rev-parse --show-toplevel)/logs
	DIR=${LOGSPATH}/${FROMASR}/${index_name}/${file_name}.pvlogs
	TRDIR=${LOGSPATH}/${FROMASR}/${index_name}/${file_name}.transcript
    mkdir -p $DIR
    mkdir -p $TRDIR
	echo "$UNB $CLIENT -f $FROMASR -i en-EU -t text < $i | $TEETS $DIR/${file_name}.en.asr" > $DIR/cmd
	bash $DIR/cmd
	cat "$DIR/${file_name}.en.asr" | cut -d" " -f2- | online-text-flow-events --text | sed -r '/^\s*$/d' > ${TRDIR}/${file_name}.en.asr
	asrev_cmd="../../../SLTev/ASRev_updated/ASRev --ost $(basename "$temp_name" | rev | cut -d. -f2- | cut -d "_" -f2- | rev)t --asr ${TRDIR}/${file_name}.en.asr"
done
