#!/bin/bash
REF=$1
BASE=/lnet/spec/work/people/machacek/elitr/cruise-control
ABS=$BASE/SLTev
if [[ $REF != /* ]]; then
	WD=`pwd`
else
	WD=""
fi
if [ -z "$2" ]; then
	lan=cs
else
	lan=$2
fi
# TODO: this works only on úfal cluster, and on Dominik's account where he has tokenizer.perl in ~/bin
tmp=`mktemp -d --tmpdir=/tmp`
#cd $tmp
./tokenizer.perl -l $lan > input.tok 
./tokenizer.perl -l $lan < $WD/$REF > ref.tok 
#$ABS/mwerSegmenter -h
$ABS/mwerSegmenter -hypfile input.tok -mref ref.tok
ret_code=$?
./detokenizer.perl -l $lan < __segments
cd $tmp
rm -rf $tmp
exit $ret_code
