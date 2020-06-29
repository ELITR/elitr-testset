#!/usr/bin/env bash
#this script runs all pre-commit checks, needs to return exit code 0 to allow commiting to the repo

# if any command inside script returns error, exit and return that error 
set -e

# magic line to ensure that we're always inside the root of our application,
# no matter from which directory we'll run script
cd "${0%/*}/.."

echo "Running tests"
./checks/check_file_length.sh
echo "done!" && exit 0
