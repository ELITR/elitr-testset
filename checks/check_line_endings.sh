#! /bin/bash
# this script finds and reports files with windows-like line endings '\r\n'

cd "${0%/*}/.."
root_dir="./documents"

for item in `find $root_dir`; do
	endings=`file $item`
	if [[ $endings == *"CRLF"* ]]; then
		echo "WARNING: File:" $item "has CRLF line terminators"
	fi
done
