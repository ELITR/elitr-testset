#! /bin/bash
#all documents have to use utf8 or ascii encoding

cd "${0%/*}/.."
root_dir='./documents'

for file in `find $root_dir -type f -not -path *"WORK"*`; do
	filetype=`file -i $file | awk '{ print $2 }' | sed 's/;//g'`
	encoding=`file -i $file | awk '{ print $3 }' | awk 'BEGIN{ FS="="} { print $2 }'`
	if [[ "$filetype" == "text/plain" ]]; then
		if [[ "$encoding" != "utf-8" && "$encoding" != "us-ascii" ]]; then
			echo "WARNING: File" $file "has a non-standard encoding:" $encoding
		fi
	fi
done
