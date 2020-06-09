This directory illustrates the expected (ideal) file formats of your outputs
for the IWSLT2020 Non-Native Speech Translation
http://iwslt.org/doku.php?id=non_native_speech_translation


As the task description specifies, we seek:
- ASR-only submissions
- ASR+MT submissions
- SLT submissions (i.e. only MT outputs without the intermediate ASR)

If you would like to make an MT-only submission, please get in touch, we will
provide you with our best ASR outputs.


The main focus of the task is on precision of ASR and MT. The timestamps serve
for the secondary evaluation of delay and flicker.

If the details are not available in your systems, please send us the best
details you can, ideally some time before the submission deadline, so that we
can negotiate what to do.

The ideal formats include:
- P or C, indicating if the update should be deemed a Partial or Complete
  sentence
- emission time (when the update was printed)
- start time
- end time indicating the span in the speech that the given update transcribes
  (ASR output) or translates (MT output)

All timestamps are in centiseconds.

The ideally formatted sample ASR output is available in:
  ideal-asr-output.txt
Two ideally formatted sample MT outputs are in:s
  ideal-mt-output.cs ... translation into Czech
  ideal-mt-output.de ... translation into German
(These sample outputs are actually of a pretty bad ASR/MT quality.)

Foreseen simplifications of the output (if you cannot produce full details):

- Only Complete outputs, i.e. full sentences:
  # see the output of this command:
  grep ^C ideal-asr-output.txt
  # e.g.:
  # C 9241 449 7979 With these words come in good stuff that if on you in is for the good OK so.

- Only complete outputs and no time relation to original sound:
  grep ^C ideal-asr-output.txt \
  | sed 's/^C \([0-9][0-9]*\) [0-9][0-9]* [0-9][0-9]*/C \1 0 0/'
  # e.g.:
  # C 9241 0 0 With these words come in good stuff that if on you in is for the good OK so.


- Only complete outputs and no time relation to original sound, not even print time available:
  grep ^C ideal-asr-output.txt \
  | sed 's/^C [0-9][0-9]* [0-9][0-9]* [0-9][0-9]*/C 0 0 0/'
  # e.g.:
  # C 0 0 0 With these words come in good stuff that if on you in is for the good OK so.

- Failing to indicate Partial/Complete:
  sed 's/^[PC]/X/' < ideal-asr-output.txt
  # e.g.:
  # X 534 195 467 With...
  # X 582 298 503 With these...

Do not hesitate to contact us if you have any questions.

Ondřej Bojar, bojar@ufal.mff.cuni.cz
Ebrahim Ansari, ansari@ufal.mff.cuni.cz
Sebastian Stüker, sebastian.stueker@kit.edu
