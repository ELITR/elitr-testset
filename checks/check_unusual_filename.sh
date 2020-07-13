#!/bin/bash
#checks all documents if they are named according to the documentation
#files in directories named *WORK* are ignored, these are not prepared yet

cd "${0%/*}/.."

exts=`cat ./checks/valid_extensions.txt`

for file in `find ./documents/ -type f -not -path *"WORK"*`; do
	extension=`echo $file | awk 'BEGIN { FS="."; }{ print $NF }'`
	if [[ $exts != *"$extension"* ]]; then
		echo "WARNING: File" $file "has an undocumented extension"
	fi
done
