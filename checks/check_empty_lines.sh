#!/bin/bash
#checks for empty lines in raw language files, gives a warning if found

cd "${0%/*}/.."
file="./documents/iwslt2020-nonnative-slt/devset/auditing-portuguese.OSt"
exit_code=0

for file in `find ./documents -type f -not -path *"WORK"* | egrep -v '\.(mp3|txt|md|mkv|ass|mp4|aac|link)$' `; do
	while read line; do
		if [[ "$line" == "" || "$line" == " " ]]; then
			echo "WARNING: Raw language file $file contains empty lines."
			exit_code=1
			break
		fi
	done < $file
done

exit $exit_code
