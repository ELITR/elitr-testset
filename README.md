# ELITR Test Set
ELITR collection of test sets, for ASR, MT and SLT

## Organization of the Repository

The repository consists of "documents" and "indices".

One document is one text or speech or video equipped with its language variants. Indices are useful sets of documents.

### Documents

"Documents" are identified by their **basepathname**, i.e. the relative path in this directory and the basename.

Filename **suffixes** are used to indicate the language and processing:

```
.README   ... the history of creation of this document, ***including links***
.WORK     ... should be a directory of parts that are not yet properly processed; to be removed when done
.en.mp3   ... a backup of the sound in lossy format, **if small enough**
.en.mp3.URL . the URL where to get the full file, if the file can't fit here; similarly for wav.URL etc.
.en.OSt   ... original speech in language 'en', 't'ranscribed
.en.OStt  ... original speech in language 'en', 't'ranscribed and word-level 't'imestamped
.en.TTcs1 ... original speech/text in language 'en' translated as text to language 'cs'
              the '1' is used only if we have more reference translations to distinguish them
.en.IScs.mp3 ... original speech in 'en' human-interpreted to 'cs', the sound of it
.en.IStcs    ... original speech in 'en' human-interpreted to 'cs' and 't'ranscribed
.en.ISttcs    ... original speech in 'en' human-interpreted to 'cs' and 't'ranscribed, 't'imestamped
```

The files ``OSt`` and ``TT??`` need to be parallel.

### Indices

Because every document can be equipped with a different set of variantions (and thus can or cannot serve in the evaluation of ASR, MT, and/or SLT), we will **build indices**.

Each index will be a simple list of basepathnames of documents that are good for a purpose, for instance:

- all files for SLT of English into Czech in the auditing domain
- all files for English ASR in the computational linguistics domain
- all files for Czech ASR regardless the domain
