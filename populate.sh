#!/bin/bash
# This script should be run after git clone and git pull.
# It walks over all files .LINK and creates the corresponding main file:
# - if available (at UFAL network) a symlink is created
# - if not available, the file is downloaded
#
# !! No updates of the files are handled, it is assumed that these files are
# fixed. Once you get them, they should never change.
# md5sums are also quite heavy, so we test them only after the first download
# of the file.
#
# If you belong to a partner of ELITR, set the environment variable
#   ELITR_CONFIDENTIAL_PASSWORD to the password. The script will download also
# the confidential document of elitr-testset

function die() { echo "$@" >&2; exit 1; }
set -o pipefail  # safer pipes
MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get script directory

function warn() { echo "$@" >&2; }

warn "Making sure that $MYDIR will contain all non-versioned files."

baseurl="https://ufallab.ms.mff.cuni.cz/~bojar/elitr-testset"

cd "$MYDIR" || die "Failed to chdir to: $MYDIR"

for f in `find documents -name '*.LINK'`; do
  # warn "Checking $f"
  tgtf=${f/.LINK/}
  if [ -e $tgtf ]; then
    # warn "  $tgtf exists, nothing to do"
    true
  else
    sourcef=$(cat $f)
    if [ -e $sourcef ]; then
      # warn "  using $sourcef"
      ln -s $sourcef $tgtf || die "Failed to symlink $sourcef"
    else
      url=$baseurl/$tgtf
      warn "  Downloading $url"
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

if [ -z "$ELITR_CONFIDENTIAL_PASSWORD" ] \
   && [ -e documents/confidential-password ]; then
  warn "Reusing ELITR_CONFIDENTIAL_PASSWORD from the past"
  ELITR_CONFIDENTIAL_PASSWORD=$(cat documents/confidential-password)
fi

ufal_confid_dir=/net/data/ELITR/elitr-testset-nonversioned-files/elitr-testset-confidential-files
if [ -e "$ufal_confid_dir" ]; then
  if [ ! -e "$MYDIR/documents/confidential" ]; then
    warn "We are at UFAL and do not have our confidential files yet."
    warn "=> Symlinking $ufal_confid_dir to $MYDIR/documents/confidential"
    pushd "$MYDIR"/documents/ > /dev/null || die "Failed to pushd"
    ln -s "$ufal_confid_dir" ./confidential || die "Failed to symlink"
    popd > /dev/null || die "Failed to popd"
    warn "Will be using UFAL-common confidential files directly, no versions."
  fi
elif [ ! -z "$ELITR_CONFIDENTIAL_PASSWORD" ]; then
  latest=$(wget -q -O- --user elitr --password "$ELITR_CONFIDENTIAL_PASSWORD" $baseurl/confidential/elitr-testset-confidential-files.latest)
  [ ! -z "$latest" ] || die "Failed to get latest package name for confidential files. Is the password '$ELITR_CONFIDENTIAL_PASSWORD' correct for $baseurl/confidential?"
  # save the password
  echo "$ELITR_CONFIDENTIAL_PASSWORD" > documents/confidential-password \
  || warn "Failed to save ELITR_CONFIDENTIAL_PASSWORD for future use"
  # check our version
  [ -e "$MYDIR"/documents/confidential/version ] \
  && our=$(cat "$MYDIR"/documents/confidential/version)
  if [ "$latest" == "$our" ]; then
    warn "$MYDIR/documents/confidential is up to date."
  else
    warn "Downloading $latest"
    wget -q --user elitr --password "$ELITR_CONFIDENTIAL_PASSWORD" \
      $baseurl/confidential/$latest -O "$MYDIR"/documents/$latest \
    || die "Failed to download $baseurl/confidential/$latest"
    pushd "$MYDIR"/documents/ > /dev/null || die "Failed to pushd"
    # unpack into directory called latest
    latestdir=${latest/.tar.bz2/}
    mkdir $latestdir && tar xjf $latest -C $latestdir \
    || die "Failed to extract $latest"
    if [ -e confidential ]; then
      [ ! -L confidential ] \
      && die "$MYDIR/documents/confidential is not a symlink, failing to update"
      rm confidential || die "Failed to delete symlink"
    fi
    ln -s $latestdir confidential \
    || die "Failed to update symlink"
    echo $latest > $latestdir/version || die "Failed to save version"
    popd > /dev/null || die "Failed to popd"
    warn "Confidential files now at version $latest"
  fi
fi
