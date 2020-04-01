#!/bin/bash
if false; then
	for i in ??/*spl-s ; do sed -r 's/(^| )\([^ ]*\) *//g;s/<[^>]*>//g' < $i | grep . > $i.no-par ; done
	for i in cs/*spl-s.no-par ; do fix-cs-quotes-etc.pl < $i > $i.fix-q ; done
fi


for l in ??; do 
	if [[ "$l" == cs ]]; then
		suf=no-par.fix-q
	else
		suf=no-par
	fi
	no=""
	ref=$l/tst2015.en-$l.ref.txt
	for i in `cat ../FILE_ORDER`; do 
		f=$l/$i.$l.txt.spl-s.$suf
		[ ! -f $f ] && no=true
		cat $f
	done > $ref
	if [ ! -z "$no" ]; then
		echo $ref missing 
		rm $ref
	fi
done
