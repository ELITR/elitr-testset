# Indices

This directory contains filelists, called "indices", each created for a particular evaluation purpose.

Some of these indices are created automatically, these usually include all files of a given nature (e.g. Czech speech + Czech transcript).
Other indices are manually curated, esp. for evaluation purposes of a specific domain.

The index files are interpreted by SLTev and have a simple plain text format:
- they are simply a set of files from the ``documents/`` directories
- blank lines in index files are for readability only, they make no difference to SLTev
- comments can be added as lines starting with ``#``
- a special directive ``#include OTHER-INDEX-FILE`` can be used to create supersets of indices

## Best Practice for Maintaining Index Files

- Manually-created index files should all start with a comment header, explaining the purpose of the index.
- If an index file is used in a paper or report, this paper or report *must be referenced* in the comment and the top of the index file.
  In the respective paper, state that your approach "...was evaluated on INDEX-FILENAME of elitr-testset COMMIT-ID..." (and cite elitr-testset)

## Comments about Selected Index Files

asr-english-any-domain and mt-auditing are manually created examples, we will keep them for now. 

SUFFIX-VIEW is a list of all documents and their format (eg. original speech it's recording, translations etc.)

