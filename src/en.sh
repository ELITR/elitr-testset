#!/bin/bash
source common.sh

FROM=en-EU
FROM_S=EN
FROMASR=en-EU-ufal-da-20200120

mkfifo $DIR/input-pipe
i=1;
eng_cmd="$UNB $CLIENT -f $FROMASR -i $FROM -t text < $DIR/input-pipe | $TEETS $DIR/${filename}.ASR${FROM_S,,}"

# This online-text-flow-events is only for ASR
cmd="$eng_cmd"

i=$((i + 1))
#Uses Phils Model
rb="rb-EU_fromEN-en_to_41"
cmd="$cmd | $TEE >( $UNB $NEW_TCLIENT -f $FROM -i ${rb} "\"" | $TEE $DIR/${i}-rb-out-${FROM}2rb"

for t in ${!rb_langs[@]}; do
    # split MT
    cmd="$cmd | $TEE >( $UNB cut -f1,${split_list[$t]} | $UNB sed 's/ de\t/ /' > $DIR/${filename}.MT${rb_langs[$t]} )"

done

cmd="$cmd )"

# creating pvconfig
echo "SRCLANG=${FROM}" > ${DIR}/pvconfig
echo "ASR Worker=${FROMASR}" >> ${DIR}/pvconfig
echo "MT Worker=${rb}" >> ${DIR}/pvconfig


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

# Transcript processing file
REF_DIR=$(dirname $1)
echo "./post-transcript.sh $DIR $REF_DIR" >> run2transcript.sh