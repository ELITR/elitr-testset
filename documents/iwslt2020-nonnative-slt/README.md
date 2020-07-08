# iwslt2020-nonnative-slt
Dev and test set preparations of IWSLT shared task on non-native speech translation

## TODO:

- create an index of files included in elitr-testset

## Explanation of File Extensions

```
These are english files, unless language is specified (eg. TTcs, TTde)

*.wav  ... the input audio file in the lossless format
           The wav files are too big to be stored in this repo, they live outside.

*.aac  ... for some sources, this is the original sound format; versioned here
*.mp3  ... for backup purposes, we have these files versioned here

*.RS.* ... respeaker speech, contents should be the same as .OSt, but spoken by a different person

*.OSt  ... original speech, transcribed
           Manually revised transcripts.
           One sentence per line, no time stamps.
*.OStt ... original speech, transcribed, timestamped
           Manually revised transcripts.
           Partial as well as Complete sentences, timestamped with
           the starting and ending time indicating when the words were uttered.
*.TTcs ... text-based translation into Czech
           Reference translation of each of the Complete segments.
           No timestamps are included.
           Some sources have multiple independent translations, denoted TTcs1, TTcs2, ...
*.TTde ... text-based translation into German
           Reference translation of each of the Complete segments.
           No timestamps are included.
```


## Known Problems

- **Domain-specific abbreviations** are unreliable and missing. Despite our efforts, it is very likely that highly domain specific abbreviations were not spotted in the processing, because we only had access to the sound and not the slides which could have alarmed us about the abbreviations.

- **Segmentation into sentences** is often arbitrary (people do not speak in sentences) and sometimes simply wrong. This then also affected the quality of the reference translation.
