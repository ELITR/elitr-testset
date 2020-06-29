#!/bin/bash

#verifies that paralel text files (OST, TTcs{1,2}, TTde) have the same number of lines.

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
    continue #source file does not have any translations, ignore it (probably an ASR file)
  fi

  if test -f "$ttcs"; then
    are_lengths_equal=`echo -e "${length_ost}\n${length_ttcs}\n${length_ttde}" | sort -u | wc -l`
    if [ $are_lengths_equal -ne 1 ]; then
      echo "Error: $ost and its paralel documents don't have the same number of lines"
      echo "$ost : $length_ost"
      echo "$ttcs : $length_ttcs"
      echo "$ttde : $length_ttde"
      exit 1 #not equal is an error
    fi
  else
    are_lengths_equal=`echo -e "${length_ost}\n${length_ttcs1}\n${length_ttcs2}\n${length_ttde}" | sort -u | wc -l`
    if [ $are_lengths_equal -ne 1 ]; then
      echo "Error: $ost and its paralel documents don't have the same number of lines"
      echo "$ost : $length_ost"
      echo "$ttcs1 : $length_ttcs1"
      echo "$ttcs2 : $length_ttcs2"
      echo "$ttde : $length_ttde"
      exit 1 #not equal is an error
    fi
  fi

done

exit 0
