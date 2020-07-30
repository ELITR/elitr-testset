#!/bin/bash

source $(git rev-parse --show-toplevel)/config.sh

PPATH=$(git rev-parse --show-toplevel)/setups/src
MTPATH=$(git rev-parse --show-toplevel)/mt-wrapper
FFMPEG=$(git rev-parse --show-toplevel)/setups/ffmpeg-split-from-video-to-audio-and-m3u8-playlist
source $FFMPEG/run-slim-setup

PORT=$1
TCLIENT_PORT=4448    #   UEDIN Textclient Port
PUBTCLIENT_PORT=4448 #   Pervoice publisher client port

## set following before running common:
DATE=$(date '+%Y%m%d-%H%M%S')
DIR=$DATE-pv-run-x
# DIR=pv-run-x
FIRSTPRESENTER=x0-X0-pub
SECONDPRESENTER=x1-X1-pub

# Extra presenters for subtitles with different flicker
FIRSTPRESENTER_0=e0-E0-pub
FIRSTPRESENTER_1=e1-E1-pub
FIRSTPRESENTER_2=e2-E2-pub

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
SUBTITLER_MT=$(git rev-parse --show-toplevel)"/chopper/subtitler.sh --width=70 --desired-flicker=2"

# As per Ondrej's request- too assess the flicker in the subtitles
SUBTITLER_MT_0=$(git rev-parse --show-toplevel)"/chopper/subtitler.sh --width=70 --desired-flicker=0 --min-show-time=7.0"
SUBTITLER_MT_1=$(git rev-parse --show-toplevel)"/chopper/subtitler.sh --width=70 --desired-flicker=1"
SUBTITLER_MT_2=$(git rev-parse --show-toplevel)"/chopper/subtitler.sh --width=70 --desired-flicker=2"
czech_asr=$(git rev-parse --show-toplevel)/cuni-kaldi-czech-asr

if [ -z "$DIR" ]; then
    DIR=.
else
    mkdir -p $DIR
fi

cs_cmd="stdbuf -o0 nc localhost $PORT | $UNB $czech_asr/obsolete/timestamps-to-januslike.pl | $UNB python3 $PPATH/lower.py | $UNB sed 's/_sil_/ /g' | $UNB egrep '[0-9]+ [0-9]+ \S'"
jasper_cmd="stdbuf -o0 nc localhost $PORT "

otf="online-text-flow-"

# rainbow packet # I removed CS and DE from this list. CS is source of ASR itself and we use linda DE MT
# DE 16
# CS 12
# rb_langs=  ('ar' 'az' 'be' 'bg' 'bs' 'cs' 'da' 'de' 'el' 'en' 'es' 'et' 'fi' 'fr' 'ga' 'he' 'hr' 'hu' 'hy' 'is' 'it' 'ka' 'kk' 'lb' 'lt' 'lv' 'me' 'mk' 'mt' 'nl' 'no' 'pl' 'pt' 'ro' 'ru' 'sk' 'sl' 'sq' 'sr' 'sv' 'tr' 'uk')
# split_list=('2'  '4'  '6'  '8'  '10' '12' '14' '16' '18' '20' '22' '24' '26' '28' '30' '32' '34' '36' '38' '40' '42' '44' '46' '48' '50' '52' '54' '56' '58' '60' '62' '64' '66' '68' '70' '72' '74' '76' '78' '80' '82' '84' )

# rb_langs=('ar' 'az' 'be' 'bg' 'bs' 'cz' 'da' 'el' 'en' 'es' 'et' 'fi' 'fr' 'ga' 'he' 'hr' 'hu' 'hy' 'is' 'it' 'ka' 'kk' 'lb' 'lt' 'lv' 'me' 'mk' 'mt' 'nl' 'no' 'pl' 'pt' 'ro' 'ru' 'sk' 'sl' 'sq' 'sr' 'sv' 'tr' 'uk')
# split_list=('2'  '4'  '6'  '8'  '10' '12' '14' '18' '20' '22' '24' '26' '28' '30' '32' '34' '36' '38' '40' '42' '44' '46' '48' '50' '52' '54' '56' '58' '60' '62' '64' '66' '68' '70' '72' '74' '76' '78' '80' '82' '84' )

## for worker rb42-EU-big-subset- all
# rb_langs=("be" "cs" "da" "en" "es" "fr" "hu" "it" "nl" "pl" "ro" "ru" "sk" "sl")
# split_list=('2'  '4'  '6'  '8'  '10' '12' '14' '16' '18' '20' '22' '24' '26' '28')

# ## for worker rb42-EU-big-subset- removing en
# rb_langs=("be" "cs" "da" "es" "fr" "hu" "it" "nl" "pl" "ro" "ru" "sk" "sl")
# split_list=('2' '4'  '6' '10' '12' '14' '16' '18' '20' '22' '24' '26' '28')

## for worker rb42-EU-big-subset- temporary testing
#rb_langs=("cs" "ro")
#split_list=('4' '22')

# for worker rb42-EU-big-subset
# rb_langs=("be" "cs" "da" "fr" "hu" "nl" "pl" "ro" "ru" "sk" "sl")
# split_list=('2'  '4'  '6'  '12' '14' '18' '20' '22' '24' '26' '28')

# # for worker UEDIN's rb-EU_fromEN-en_to_41
rb_langs=("de" "ro" "cs" "fr" "hu" "pl" "nl")
split_list=('2' '4'  '6'  '8' '10' '12' '14')

# for worker UEDIN's rb-EU_fromEN-en_to_41 - temporary testing
# rb_langs=("ro")
# split_list=('4')

echo "############################################################################"
echo "#                                                                           #"
echo "#                                                                           #"
echo "#                         Welcome to ELITR SLT                              #"
echo "#                                                                           #"
echo "#                                                                           #"
echo "############################################################################"
echo

echo "Make a selection form the list of ASR workers"
avail_asr_workers=$(`git rev-parse --show-toplevel`/agg-table.sh | grep 'audio.*' | grep 'Yes*' | grep ${FROM} | awk '{print $1 }')
asr_workers=($avail_asr_workers)
if [ -z "${asr_workers}" ]
then
      echo
      echo "No ASR workers are running at the moment. Try again later."
      exit
else

      for i in "${!asr_workers[@]}"; do
        printf "\t%d. %s\n" "$(($i+1))" "${asr_workers[$i]}"
      done
      read -p "Your choice : " asr_choice
      echo "*********************"

      echo "Select MT worker(s)"
      # asr='en-EU'
      asr=${asr_workers[$asr_choice-1]:0:5}
      op_avail_mt_workers=$(`git rev-parse --show-toplevel`/agg-table.sh | grep '  text.* text' | grep -v 'pub' | awk -v pat="$asr" '$1 ~ pat' | awk '{print $3}')
      # asr_workers=($(printf "%s\n" "${avail_asr_workers[@]}" | sort -u | tr '\n' ' '))
      mt_workers=($op_avail_mt_workers)

      for i in "${!mt_workers[@]}"; do
        printf "\t%d. %s\n" "$(($i+1))" "${mt_workers[$i]}"
      done
      # read -p "Your choice (separated by space) : " asr_fp
      mt_fp="\n"
      echo "Your choice: "
      until [ "a$mt_fp" = "a" ];do
      #    echo "Enter next E-mail: "
        read mt_fp
        mt_fps=$mt_fps" "$mt_fp
      done
      echo $mt_fps
      echo "*********************"

fi
