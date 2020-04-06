#!/bin/bash

function die() { echo "$@" >&2; exit 1; }
set -o pipefail  # safer pipes
function warn() { echo "$@" >&2; }

enfile="$1"
otherfile="$2"
outfile="$3"

TRTOKBASHSOURCE=/ha/home/bojar/opt/trainable-tokenizer/installation/trtok.bashrc
HUNALIGNCALL="/home/bojar/diplomka/umc/devel/tools/align/hunalignwrapper.pl --hunalign=/home/bojar/diplomka/umc/devel/tools/align/../external/hunalign/hunalign/hunalign"


[ -z "$outfile" ] \
&& die "usage: $0 english-file.txt otherlang-file.txt outfile.txt"
[ -e "$enfile" ] || die "Not found: $enfile"
[ -e "$otherfile" ] || die "Not found: $otherfile"

[ -e "$outfile" ] && warn "Overwriting: $outfile"

tempdir=$outfile.temp
mkdir $tempdir

source $TRTOKBASHSOURCE

cp $enfile $tempdir/src.in
cp $otherfile $tempdir/tgt.in

trtok tokenize czeng/en -r /in/tok/ $tempdir/src.in
trtok tokenize czeng/cs -r /in/tok/ $tempdir/tgt.in

$HUNALIGNCALL $tempdir/src.in $tempdir/tgt.in > $outfile
