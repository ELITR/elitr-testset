#!/bin/bash

cd "${0%/*}/../.."
translated="./documents/wmt19-elitr-testsuite/translated/cs-de"
reference="./documents/wmt19-elitr-testsuite/reference"

rm ./indices/elitr-testsuite-cs-de

for text in `ls "$translated"`; do
	original=`find $reference -name "*$text*.en"` #original texts are in english
	czech=`find $reference -name "*$text*.cs"`
	german=`find $reference -name "*$text*.de"`

	echo $text >> ./indices/elitr-testsuite-cs-de
	echo "original:" >> ./indices/elitr-testsuite-cs-de
	echo "$original">> ./indices/elitr-testsuite-cs-de
	echo "human translation:">> ./indices/elitr-testsuite-cs-de
	echo "$german">> ./indices/elitr-testsuite-cs-de
	echo "$czech">> ./indices/elitr-testsuite-cs-de
	echo "machine translation:">> ./indices/elitr-testsuite-cs-de
	find "$translated/$text" -type f >> ./indices/elitr-testsuite-cs-de
	echo -e "\n">> ./indices/elitr-testsuite-cs-de
done
