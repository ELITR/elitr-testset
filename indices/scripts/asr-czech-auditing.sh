#!/bin/bash
#list all data in the domain of auditing that can be used to evaluate czech asr (that have a recording and an OSt)

cd "${0%/*}/.."
f1=`cat ./auto-iwslt2020-wgvat| grep 'IS'`

files=`echo "$f1"`
./scripts/group_files.sh "$files" > auto-asr-czech-auditing
