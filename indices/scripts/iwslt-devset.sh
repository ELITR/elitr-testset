#!/bin/bash

cd "${0%/*}/.."
./scripts/find_files.sh /home/account/work/elitr-testset/documents/iwslt2020-nonnative-slt/devset/ > iwslt_devset
