# ELITR Test Set
ELITR collection of test sets, for ASR, MT and SLT

## Installation

Some big files are not included in the repository. You download them after the cloning/update using ``populate.sh``.
This cloning can be automated via the provided git hook.

```
git clone https://github.com/ELITR/elitr-testset.git
  # Get the versioned files
cd elitr-testset
./populate.sh
  # Run the repo population with big files for the first time
  # Partners in the ELITR project should provide the password to get
  # also the confidential files:
  #   ELITR_CONFIDENTIAL_PASSWORD=... ./populate.sh
git config --local core.hooksPath githooks/
  # Ensure that populate.sh is called after every pull
```

## Organization of the Repository

The repository consists of "documents" and "indices" and "checks".

One document is one text or speech or video equipped with its language variants. Indices are useful sets of documents. Checks are scripts that verify document integrity.

### Documents

"Documents" are identified by their **basepathname**, i.e. the relative path in this directory and the basename.

Filename **suffixes** are used to indicate the language and processing:

```
.README      ... the history of creation of this document, ***including links***
.WORK        ... should be a directory of parts that are not yet properly processed; to be removed when done
.EXTRA       ... a directory with related materials to the particular talk, e.g. slides, processed in any useful way
.en.OS.mp3   ... a backup of the sound in lossy format, **if small enough**
.en.OS.mp3.LINK . the path on the UFAL cluster where to get the full file, if the file can't fit here; similarly for wav.LINK etc.
             ... the LINK files are interpreted after git pull in a process we call "populating your elitr-testset working copy"
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
*(Grammar note: 'indices' is the plural form of the word 'index')*

Because every document can be equipped with a different set of variantions (and thus can or cannot serve in the evaluation of ASR, MT, and/or SLT), we will **build indices**.

Each index will be a simple list of basepathnames of documents that are good for a purpose, for instance:

- all files for SLT of English into Czech in the auditing domain
- all files for English ASR in the computational linguistics domain
- all files for Czech ASR regardless the domain

### Populating Working Copy with Big Files

After you obtain your working copy of elitr-testset via ``git clone`` (or update it via ``git pull``), you may need to download also big files which are not directly included in ``documents/`` but only represented there as ``*.LINK`` files.

This population is done by running a simple script ``./populate.sh``. Note that many of these files may not be needed in the particular evaluation task you are doing, so this population would be ideally limited to a set of index files that you plan to use, to reduce the usage of disk space.

### Checks

We need to implement many checks of the format of everything, in a subdir called ``checks``. We will use git hooks to reject all commits that do not pass the checks.
People who wish to commit to the repository need to run ``./checks/install-hooks.sh``!

## Citing

If you make use of ``elitr-testset``, please cite the following paper:

```
@inproceedings{sltev:eacl:2021,
  author    = {Ansari, Ebrahim  and  Bojar, Ond{\v{r}}ej and Haddow, Barry and Mahmoudi, Mohammad},
  title     = {{SLTev: Comprehensive Evaluation of Spoken Language Translation}},
  booktitle = {Proceedings of the 16th Conference of the European Chapter of the Association for Computational Linguistics: Demo Papers},
  month     = {April},
  year      = {2021},
  address   = {Kyiv, Ukraine},
  publisher = {Association for Computational Linguistics},
}
```


