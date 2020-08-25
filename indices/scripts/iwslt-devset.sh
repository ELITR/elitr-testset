#!/bin/bash

cd "${0%/*}/.."
./scripts/find_files.sh ../../elitr-testset/documents/iwslt2020-nonnative-slt/devset/ > iwslt-devset
