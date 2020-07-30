#!/bin/bash
#This script convers all the wav files in a given dir into a 16K 256bit WAV files

if [ $# -ne 1 ]; then
    echo "usage: $0 <full-path to input direcotry to be processed>"
    exit
fi
PRE=$1
for i in $PRE/*.mp3; do
    echo $i
    bname=$(basename $i)
    echo $bname
    filename=$(basename "$bname" | cut -d. -f1,2)
    echo $filename
    dirname=$(dirname $i)
    op_wav="$dirname/${filename}_16K.wav"
    #ffmpeg -hide_banner -loglevel panic -y -i $i -acodec pcm_s16le -ar 16000 -codec:v copy -af pan="mono: c0=FL" $op_wav
    ffmpeg -hide_banner -loglevel panic -y -i $i -acodec pcm_s16le -ar 16000 -ac 1 $op_wav
    #rm -rf $i
done
