#!/bin/bash

#verifies that paralel text files (OST, TTcs{1,2}, TTde) have the same number of lines.

cd "${0%/*}/.."

set -e

l1=`cat ./documents/iwslt2020-nonnative-slt/devset/ami.IS1001a.OSt | wc -l`
l2=`cat ./documents/iwslt2020-nonnative-slt/devset/ami.IS1001a.TTcs | wc -l`


if [ $l1 -eq $l2 ]; then
  exit 0
else
  echo "files have incorrect number of lines"
  exit 1
fi
