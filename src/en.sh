#!/bin/bash
source common.sh

FROM=en-EU
FROM_S=EN
FROMASR=en-EU-ufal-da-20200120

# Separate path to save logs-
bname=$(basename $1)
LOGSPATH=$(git rev-parse --show-toplevel)/logs/$(dirname "$1" | cut -d"/" -f10-)

DATE=$(date '+%Y%m%d-%H%M%S')
filename=$(basename "$bname" | cut -d. -f1,2)
DIR=${LOGSPATH}/${FROMASR}/${filename}.pvlogs
TRDIR=${LOGSPATH}/${FROMASR}/${filename}.transcript

if [ -z "$DIR" ]; then
    DIR=.
else
    mkdir -p $DIR
    mkdir -p $TRDIR
fi


mkfifo $DIR/input-pipe
i=1;
eng_cmd="$UNB $CLIENT -f $FROMASR -i $FROM -t text < $DIR/input-pipe | $TEETS $DIR/${filename}.ASR${FROM_S,,}"

cmd="$eng_cmd"

# creating pvconfig
echo "SRCLANG=${FROM}" > ${DIR}/pvconfig
echo "ASR Worker=${FROMASR}" >> ${DIR}/pvconfig


echo $cmd > $DIR/cmd
sed -i '1 i\#!/bin/bash' $DIR/cmd
chmod a+x $DIR/cmd

echo -n "stdbuf -o0 arecord -f S16_LE -c1 -r 16000 -t raw -D default | "
echo -n "$cmd" | python3 pretify-bash.py

#echo "# Once the whole system is up, start playback with this command:" >&2
#echo "echo STARTED | $TEETS $DIR/STARTTIME; cat $1 > $DIR/input-pipe" >&2

echo "sleep 5" > $DIR/start-playback
echo "echo STARTED | $TEETS $DIR/STARTTIME; cat $1 > $DIR/input-pipe" >> $DIR/start-playback

chmod a+x $DIR/cmd
chmod a+x $DIR/start-playback

echo "nohup $DIR/cmd &" > $bname-start-cmd.tsk
echo "nohup $DIR/start-playback &" >> $bname-start-cmd.tsk
echo "sleep $(soxi -D $1)" >> $bname-start-cmd.tsk
echo "sleep 180" >> $bname-start-cmd.tsk

echo "$(realpath $bname-start-cmd.tsk)" >> run-${FROM_S}.tsk
chmod a+x *.tsk

# ASR Transcript processing file
REF_DIR=$(dirname $1)
echo "./post-transcript.sh $DIR $REF_DIR" >> run2transcript.sh