#!/bin/bash
# This script should be run after git clone and git pull.
# It walks over all files .LINK and creates the corresponding main file:
# - if available (at UFAL network) a symlink is created
# - if not available, the file is downloaded
#
# !! No updates of the files are handled, it is assumed that these files are
# fixed.
# md5sums are also quite heavy, so we test them only after downloading the file.

function die() { echo "$@" >&2; exit 1; }
set -o pipefail  # safer pipes
MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get script directory

function warn() { echo "$@" >&2; }

warn "Making sure that $MYDIR will contain all non-versioned files"

cd "$MYDIR" || die "Failed to chdir to: $MYDIR"

for f in `find documents -name '*.LINK'`; do
  warn "Checking $f"
  tgtf=${f/.LINK/}
  if [ -e $tgtf ]; then
    warn "  $tgtf exists, nothing to do"
  else
    sourcef=$(cat $f)
    if [ -e $sourcef ]; then
      # warn "  using $sourcef"
      ln -s $sourcef $tgtf || die "Failed to symlink $sourcef"
    else
      url=http://ufallab.ms.mff.cuni.cz/~bojar/elitr-testset/$tgtf
      warn "  downloading from $url"
      wget --quiet -O$tgtf $url || die "Failed to download $sourcef"
      sum=$(md5sum $tgtf)
      [ "$sum" != "" ] || die "Failed to get md5sum for $tgtf"
      [ -e $tgtf.md5 ] || die "Reference md5sum for $tgtf not found"
      expsum=$(cat $tgtf.md5)
      if ! diff <(echo "$sum") <(echo "$expsum"); then
        warn "md5sum differ:"
        warn "downloaded: $sum"
        warn "  expected: $expsum"
        exit 1
      fi
    fi
  fi
done
