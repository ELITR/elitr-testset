#!/bin/bash

if [[ $_ == $0 ]]; then
  echo "This script needs to be sourced!" >&2
  exit 1
fi

source ../../p3/bin/activate
export LD_LIBRARY_PATH=$(pwd)/../../pv-platform-production-connector/lib64:$LD_LIBRARY_PATH

