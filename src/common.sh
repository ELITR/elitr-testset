#!/bin/bash

if [ $# -ne 2 ] ; then
    echo "usage: $0 <path_to_index> <FP of the worker"
    exit
fi

source ../../config.sh

PPATH=/lnet/spec/work/people/kumar/cruise-control/setups/src
MTPATH=/lnet/spec/work/people/kumar/cruise-control/mt-wrapper


TCLIENT_PORT=4448    #   UEDIN Textclient Port
PUBTCLIENT_PORT=4448 #   Pervoice publisher client port
CLIENT_PORT=4448

## set following before running common:


web_link="ws://quest.ms.mff.cuni.cz:5000/textflow"

UNB="stdbuf -oL"

TEE=$PVPATH/eet
#[ ! -f ./eet ] && ln -s $TEE ./eet
TEE="$UNB ./eet"

TEETS=$PVPATH/eet-timestamped
#[ ! -f ./eet-timestamped ] && ln -s $TEETS ./eet-timestamped
TEETS="$UNB ./eet-timestamped"

#[ ! -f ./ebclient ] && ln -rs $CLIENT ./ebclient
CLIENT="./ebclient -s $MEDIATOR -p $CLIENT_PORT --timestamps -r"

mt_wrapper="$MTPATH/mt-wrapper.py"
segm_wrapper="$MTPATH/segm-wrapper.py"
batching="--no-batching"
events="--eventsIn"
add_params="--size=100 --min_status 1 10 --mask-k 1 --finalization-time 300 --vocab /home/elitr/sagar/cruise-control/pref-mt-wrapper/vocab.encs.spm"

#[ ! -f ./textclient ] && ln -rs $TCLIENT ./textclient
TCLIENT="$PPATH/mt-cache.py ./textclient -s $MEDIATOR -p $TCLIENT_PORT" # --timestampsIn --timestampsOut ommited by Dominik

SEGM_TCLIENT="./textclient -s $MEDIATOR -p $TCLIENT_PORT "
# Integrated with MT wrapper
NEW_TCLIENT="$mt_wrapper --mt "\""./textclient -p $TCLIENT_PORT "

czech_asr=$(git rev-parse --show-toplevel)/cuni-kaldi-czech-asr



otf="online-text-flow-"
# # for worker UEDIN's rb-EU_fromEN-en_to_41
rb_langs=("de" "ro" "cs" "fr" "hu" "pl" "nl")
split_list=('2' '4'  '6'  '8' '10' '12' '14')
