### This directory contains necessary scripts needed to generate transcripts and get them ready for evaluation in an appropriate manner.

The elitr teset set consists of-
* Audio recordings in mp3, agg and wav format
* Text-based documents

To keep the processing simple, we follow two different pipes-
1. Audio -> ASR transcripts -> MT ->  Translation in max possible available languages.
2. Text based documents -> MT -> Translation in max possible available languages.

### Usage
#### 1. Source- Audio

1.1 Convert all available audio recordings into 16K 256 bit format.
```
usage: ./converto16K.sh <full-path to input direcotry to be processed>
```
Example-
```
./converto16K.sh elitr-testset/documents/
```
1.2 Gather all the WAV files of a specific language and generate task files for bulk processing.
```
usage: ./gather_files.sh <processing script eg. en.sh, es.sh, cs.sh> <full-path to input direcotry to be processed> <dataset name>

```
Example-
```
./gather_files.sh en.sh elitr-testset/documents/iwslt2020-nonnative-slt/testset/khan-academy khan-academy
```
1.3 The above step would generate a task file named ``process_en_khan-academy.tsk``. Execute this script using `bash process_en_khan-academy.tsk`. This would again generate many task files to make the transcript generation process automatic. 

1.4 Now we are ready to generate transcripts. Execute  `nohup ./run-EN.tsk &` to keep the ASR generation process running in the background. Once the ASRs are ready, execute `nohup ./run2transcript-EN.tsk &`. This will use the ASR generated earlier to create transcripts in a readable format ready for evaluation.

1.5 These readable ASR transcripts can now be processed further to perform the MT task and generate translations. Step 1.3 also created task files with name like `mt-EN-2-rb-EU_fromEN-en_to_41.tsk` and `mt-EN-2-cs-CZ.tsk`. As can be seen, the suffix of these files contains the output fingerprint of the MT worker. Execute each of these separately to generate translations from different MT workers in different languages. Once complete these translation transcripts are ready for evaluation.

#### 2. Source- Text docs
2.1 Collect all the text-based files that need to be translated. All such text-based documents follow a strict naming pattern where the document name is suffixed with its language code.
```
usage: ./collect_source_files.sh <source dir that contains all text-based translations>
``` 
Example-
```
./collect_source_files.sh elitr-testset/documents/taus/
```
This will recursively search for text files inside the input directory and prepare task files so that each of these documents is translated into all possible languages using multiple MT workers simultaneously. This would create task files like- `only-cs-2-rb-EU_fromCS-cs_to_40-mt.flist` and `only-de-2-rb-EU_fromDE-de_to_40-mt.flist`. Execute each of these task files simultaneously.
```
nohup ./only-cs-2-rb-EU_fromCS-cs_to_40-mt.flist &> nohup-cs2rb &
nohup ./only-de-2-rb-EU_fromDE-de_to_40-mt.flist &> nohup-de2rb &
```
