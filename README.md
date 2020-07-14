# ELITR Test Set
ELITR collection of test sets, for ASR, MT and SLT

## Organization of the Repository

The repository consists of "documents" and "indices" and "checks".

One document is one text or speech or video equipped with its language variants. Indices are useful sets of documents. Checks are scripts that verify document integrity.

### Documents

"Documents" are identified by their **basepathname**, i.e. the relative path in this directory and the basename.

Filename **suffixes** are used to indicate the language and processing:

```
.README      ... the history of creation of this document, ***including links***
.WORK        ... should be a directory of parts that are not yet properly processed; to be removed when done
.en.OS.mp3   ... a backup of the sound in lossy format, **if small enough**
.en.OS.mp3.URL . the URL where to get the full file, if the file can't fit here; similarly for wav.URL etc.
.en.OS.mp3.LINK . the path on the UFAL cluster where to get the full file, if the file can't fit here; similarly for wav.LINK etc.
.mp4         ... backup of the original video, if small enough
.aac         ... backup of the original video, if small enough
.en.OSt      ... original speech in language 'en', 't'ranscribed
.en          ... if the document was never spoken, we can use simply .en to indicate it is in language 'en'
.en.OStt     ... original speech in language 'en', 't'ranscribed and word-level 't'imestamped
.en.TTcs1    ... original speech/text in language 'en' translated as text to language 'cs'
                 the '1' is used only if we have more reference translations to distinguish them
.en.IScs.mp3 ... original speech in 'en' human-interpreted to 'cs', the sound of it
.en.IStcs    ... original speech in 'en' human-interpreted to 'cs' and 't'ranscribed
.en.ISttcs   ... original speech in 'en' human-interpreted to 'cs' and 't'ranscribed, 't'imestamped
.en.RS.mp3   ... respeaker speech in 'en', same contents as OS, but spoken by a different speaker, the sound of it
.cs          ... if we do not know if the document was translated from language 'en' to 'cs'
                 (which would be indicated by '.en.TTcs') or vice versa, we can simply use 'cs' to
                 indicate the other language
                 
plus other files, generally not included in the indeces yet, probably will be renamed:
.ass - a file with timestamps and subtitles, used to create .mkv
.eaf - a file with manually processed timestamps
.json - similar to eaf, manually processed timestamps
.mkv - sound file with subtitles, made from transcription of original speech
.OSasr       ... orriginal speech, automativally transcribed
en-cs - a document in source language (en), translated into target language (cs)
```

The files ``OSt``, ``TT??`` as well as language variants without 'translation history' (``en`` or ``cs`` in the example used above) need to be parallel.

The files ``ISt*`` are typically *not* parallel with the ``OSt*`` variants.

### Indices

Because every document can be equipped with a different set of variantions (and thus can or cannot serve in the evaluation of ASR, MT, and/or SLT), we will **build indices**.

Each index will be a simple list of basepathnames of documents that are good for a purpose, for instance:

- all files for SLT of English into Czech in the auditing domain
- all files for English ASR in the computational linguistics domain
- all files for Czech ASR regardless the domain

### Checks

We need to implement many checks of the format of everything, in a subdir called ``checks``. We will use git hooks to reject all commits that do not pass the checks.
People who wish to commit to the repository need to run ./checks/install-hooks.sh ! 
