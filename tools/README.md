# Processing Tools

This directory contains tools that work **at UFAL environment**. No general
applicability is required here.

## tokenize-segment-sentalign.sh

This script has been tested on ``victoria``.

Usage:

```
tokenize-segment-sentalign.sh english.txt other.txt output.txt
```

The ``other.txt`` file is treated as Czech, sorry.

``output.txt`` will contain four columns:

```
0-1	-0.05		Ponadto przeprowadzili wywiady z 33 rolnikami wybranymi losowo do kontroli na potrzeby poświadczenia wiarygodności wydawanego przez Trybunał.
1-1	0.255	Observations	Uwagi
1-1	0.65431	Sustainable use of plant protection products affected by a slow start	Na zrównoważone stosowanie środków ochrony roślin niekorzystnie wpłynęło powolne podejmowanie działań na pierwszym etapie
```

Column 1 (0-1, 1-1 and others) indicates how many (automatically guessed) sentences have been joined. Column 2 is largely useless. Column 3 is the source sentence and Column 4 is the target sentence.


```
evaluate_asr.sh - searches for .ASR files in the documents and evaluates them against OSt file with the same name
Creates an evaluation report file in for each .ASR file in the same directory
```

## Useful Commands

```
# Convert wav to mp3
ffmpeg -i FILE.wav -acodec libmp3lame FILE.mp3
```
