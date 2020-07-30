#!/bin/bash
#checks if mp3 files included in the repository are uncorrupted
#use 'sudo apt install mp3val' to run the script

cd "${0%/*}/.."
for recording in `find ./documents/ -name "*.mp3"`; do
	result=`mp3val $recording`
	if [[ $result == *"WARNING"* ]]; then
		echo $result
	fi
done
