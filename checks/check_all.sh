#!/usr/bin/env bash
#this script runs all the checks

cd "${0%/*}/.."

echo "Running all checks"
./checks/check_file_length.sh
./checks/check_has_translation.sh
./checks/check_sentence_format.sh
echo "done!" && exit 0

