#!/usr/bin/env bash

#run this script to install pre-commit git hook, that runs the checks before every commit

GIT_DIR=$(git rev-parse --git-dir)

echo "Installing hooks..."
# this command creates symlink to our pre-commit script
ln -s ../../scripts/pre-commit.sh $GIT_DIR/hooks/pre-commit
echo "Done!"
