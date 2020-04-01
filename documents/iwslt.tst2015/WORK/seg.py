#!/usr/bin/env python3
import nltk
import sys

text = " ".join(l.strip() for l in sys.stdin.readlines())
for s in nltk.sent_tokenize(text):
    print(s)
#print(text)
