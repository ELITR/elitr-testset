#!/bin/bash

input="test.MT"
#line_mt=$(stdbuf -oL ./textclient -p 4448 -f en-EU -i rb-EU_fromEN-en_to_41 < $input)
#$echo $line_mt
#exit
IFS=''
while read line; do

  num_fields=$(echo $line |  awk -F"\t" '{print NF}')
  num_langs=$((num_fields / 2))

 for ((i=1; i<=num_langs; i++)); do
    lang=$(echo $line | cut -d$'\t' -f$(((2 * i) - 1)))
    text=$(echo $line | cut -d$'\t' -f$((2 * i)))

#    echo $lang
#    echo $text
    echo $text >> tmp/${lang}-MT
  done
done < "$input"