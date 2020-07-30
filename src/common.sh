#!/bin/bash

if [ $# -ne 1 ] ; then
    echo "usage: $0 <path to audio file>"
    exit
fi

source $(git rev-parse --show-toplevel)/config.sh

PPATH=/lnet/spec/work/people/sagar/cruise-control/setups/src
MTPATH=/lnet/spec/work/people/sagar/cruise-control/mt-wrapper


TCLIENT_PORT=4448    #   UEDIN Textclient Port
PUBTCLIENT_PORT=4448 #   Pervoice publisher client port

## set following before running common:
# Separate path to save logs-
bname=$(basename $1)
LOGSPATH=$(git rev-parse --show-toplevel)/logs/$(dirname "$1" | cut -d"/" -f10-)


DATE=$(date '+%Y%m%d-%H%M%S')
filename=$(basename "$bname" | cut -d. -f1,2)
DIR=${LOGSPATH}/${filename}.pvlogs
TRDIR=${LOGSPATH}/${filename}.transcript

web_link="ws://quest.ms.mff.cuni.cz:5000/textflow"

UNB="stdbuf -oL"

TEE=$PVPATH/eet
[ ! -f ./eet ] && ln -s $TEE ./eet
TEE="$UNB ./eet"

TEETS=$PVPATH/eet-timestamped
[ ! -f ./eet-timestamped ] && ln -s $TEETS ./eet-timestamped
TEETS="$UNB ./eet-timestamped"

[ ! -f ./ebclient ] && ln -rs $CLIENT ./ebclient
CLIENT="./ebclient -s $MEDIATOR -p $CLIENT_PORT --timestamps -r"

mt_wrapper="$MTPATH/mt-wrapper.py"
segm_wrapper="$MTPATH/segm-wrapper.py"
batching="--no-batching"
events="--eventsIn"
add_params="--size=100 --min_status 1 10 --mask-k 1 --finalization-time 300 --vocab /home/elitr/sagar/cruise-control/pref-mt-wrapper/vocab.encs.spm"

[ ! -f ./textclient ] && ln -rs $TCLIENT ./textclient
TCLIENT="$PPATH/mt-cache.py ./textclient -s $MEDIATOR -p $TCLIENT_PORT" # --timestampsIn --timestampsOut ommited by Dominik
PUBTCLIENT="./textclient -s $MEDIATOR -p $PUBTCLIENT_PORT"

SEGM_TCLIENT="./textclient -s $MEDIATOR -p $TCLIENT_PORT "
# Integrated with MT wrapper
NEW_TCLIENT="$mt_wrapper --mt "\""./textclient -p $TCLIENT_PORT "
#SEGM_TCLIENT="$segm_wrapper --mt "\"" $UNB ./textclient -p $TCLIENT_PORT "
SUBTITLER_MT=$(git rev-parse --show-toplevel)"/chopper/subtitler.sh --width=70 --desired-flicker=3"

# As per Ondrej's request- too assess the flicker in the subtitles
SUBTITLER_MT_0=$(git rev-parse --show-toplevel)"/chopper/subtitler.pl --width=70 --desired-flicker=3"
SUBTITLER_MT_1=$(git rev-parse --show-toplevel)"/chopper/subtitler.pl --width=70 --desired-flicker=2"
SUBTITLER_MT_2=$(git rev-parse --show-toplevel)"/chopper/subtitler.pl --width=70 --desired-flicker=1"
czech_asr=$(git rev-parse --show-toplevel)/cuni-kaldi-czech-asr

if [ -z "$DIR" ]; then
    DIR=.
else
    mkdir -p $DIR
    mkdir -p $TRDIR
fi

cs_cmd="stdbuf -o0 nc localhost $PORT | $UNB $czech_asr/obsolete/timestamps-to-januslike.pl | $UNB python3 $PPATH/lower.py | $UNB sed 's/_sil_/ /g' | $UNB egrep '[0-9]+ [0-9]+ \S'"
jasper_cmd="stdbuf -o0 nc localhost $PORT "

otf="online-text-flow-"
# # for worker UEDIN's rb-EU_fromEN-en_to_41
rb_langs=("de" "ro" "cs" "fr" "hu" "pl" "nl")
split_list=('2' '4'  '6'  '8' '10' '12' '14')

