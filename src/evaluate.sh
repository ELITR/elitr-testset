#!/bin/bash

cd "${0%/*}/.."
root_dir="./evaluations/iwslt2020-nonnative-slt/testset/antrecorp/en-EU-ufal-da-20200120/03_botel-proti-proudu.OS_16K.transcript/cs-CZ/"
reference_dir='./documents'

for mt in `find $root_dir -type f -name *"MTcs"` ; do
	name=`echo $mt | awk 'BEGIN{ FS = "/"} { print $NF }'`
	extension=`echo $name | awk 'BEGIN{ FS = "."} { print $NF }'`
	name=`echo $name | cut -d "." -f 1`

	ostt=`find "$reference_dir" -name "*$name*.OStt" -not -path *"outputs"*`
	translation=`find "$reference_dir" -name "*$name*.TTcs1" -not -path *"outputs"*`

	./src/align.sh $mt $ostt $translation
	./src/evaluate_single.sh $mt $ostt $translation
done
