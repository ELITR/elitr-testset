#!/bin/bash
#rename files in the iwslt repository, to include language code in all names

cd "${0%/*}/.."

for file in `find "./documents/iwslt2020-nonnative-slt/devset" -not -path "*outputs*" | egrep '\.(TTcs1|TTcs2)$'`; do
	extension=`echo $file | awk 'BEGIN { FS="."; }{ print $NF }'`
	filename=`echo $file | sed "s/$extension//g"`
	new_extension=`echo "en.$extension"`
	new_file=`echo "$filename$new_extension"`
	mv $file $new_file
done
