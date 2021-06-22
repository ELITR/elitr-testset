#!/bin/bash

cd "${0%/*}/.."
./scripts/find_files.sh ../../elitr-testset/documents/wmt19-elitr-testsuite > auto-elitr-testsuite
