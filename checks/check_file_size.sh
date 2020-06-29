#!/bin/bash

#checks if all documents are bellow 50 mb

cd "${0%/*}/.."
root_dir='./documents/'

for file in `find "$root_dir" -type f -size +50M`; do
	echo "Error: File $file is too large!"
done

if [ "$file" != "" ]; then
	exit 1 #found a large file, exit with error
else
	exit 0
fi
