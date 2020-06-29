#!/bin/bash

#finds source files (.OSt) that do not have any translations
#this may or may not be a problem, just a warning

cd "${0%/*}/.."
root_dir='./documents/'

for ost in `find "$root_dir" -name "*.OSt" -not -path "*output*"`; do #everything has an OSt
  if test -f "$ost"; then
    length_ost=`cat $ost | wc -l`
  fi

  ttcs=`echo $ost | sed 's/OSt/TTcs/g'`
  if test -f "$ttcs"; then
    length_ttcs=`cat $ttcs | wc -l`
  fi

  ttcs1=`echo $ost | sed 's/OSt/TTcs1/g'`
  if test -f "$ttcs1"; then
    length_ttcs1=`cat $ttcs1 | wc -l`
  fi

  ttcs2=`echo $ost | sed 's/OSt/TTcs2/g'`
  if test -f "$ttcs2"; then
    length_ttcs2=`cat $ttcs2 | wc -l`
  fi

  ttde=`echo $ost | sed 's/OSt/TTde/g'`
  if test -f "$ttde"; then
    length_ttde=`cat $ttde | wc -l`
  fi

  if ! test -f "$ttcs" && ! test -f "$ttcs1" && ! test -f "$ttcs2" && ! test -f "$ttde"; then
    echo "Warning: $ost does not have any translation!"
    continue
  fi

done

exit 0
