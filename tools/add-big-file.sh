#!/bin/bash
# this script adds *one* big file to our style of versioning
# in other words, the file as such is *not* added
# only the files .LINK and .md5 are added and this file is
# actually moved to big files, so that 'git pull' with our post-pull hook will
# get it back

function die() { echo "$@" >&2; exit 1; }
set -o pipefail  # safer pipes

f="$1"
[ -e "$f" ] || die "usage: $0 one-big-file.wav-or-similar"
echo "$f" | grep / > /dev/null 2>/dev/null && die "'$f' contains /"

# find the root of this checkout
root=`git rev-parse --show-toplevel`
[ -d "$root" ] || die "We are not in a checkout of elitr-testset."
root="$root/documents"
[ -d "$root" ] || die "Strange checkout, documents subdir is missing"

bigfilesroot="/net/data/ELITR/elitr-testset-nonversioned-files/elitr-testset-public-but-big-files"

pwdrelative=`readlink -f . | sed "s|^$root/||"`
[ -d "$root/$pwdrelative" ] \
|| die "Failed to get our relative path, got: $pwdrelative (ROOT: $root)"

[ -e "$bigfilesroot/$pwdrelative/$f" ] \
&& die "$f already listed in big files: $bigfilesroot/$pwdrelative/$f"

mkdir -p "$bigfilesroot/$pwdrelative" \
|| die "Failed to mkdir $bigfilesroot/$pwdrelative"

mv $f "$bigfilesroot/$pwdrelative" \
|| die "Failed to move $f to big files: $bigfilesroot/$pwdrelative"

tgtfabs="$bigfilesroot/$pwdrelative/$f"
[ -e "$tgtfabs" ] || die "Lost $f! Should have been here: $tgtfabs"

echo "Getting md5 of $f"
cat "$tgtfabs" \
| md5sum | sed "s|-$|documents/$pwdrelative/$f|" > $f.md5 \
|| die "Failed to create $f.md5"

echo "$tgtfabs" > $f.LINK \
|| die "Failed to create $f.LINK"

git add $f.md5 $f.LINK || die "Failed to git add"
