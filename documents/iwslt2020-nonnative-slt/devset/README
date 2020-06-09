Devset version 2
for the IWSLT2020 Non-Native Speech Translation
http://iwslt.org/doku.php?id=non_native_speech_translation


Due to unfortunate circumstances, we provide only a *rather small* development
set. We will try to provide more before or during the test period.


The current dev set consists of:
- 4 meetings from the AMI corpus (only one with translations, so far)
  - ami.IS1001a 15:09
  - ami.IS1001b 35:17
  - ami.IS1001c 24:06
  - ami.IS1001d 13:01
- 2 mock company presentations from Antrecorp (the rest will serve in test set)
  - antrecorp-01_teddy 1:15
  - antrecorp-02_autocentrum-oa 1:06
- 1 supreme audit presentation
  - auditing-portuguese 5:38

Total sound length: 1:35:32

All audio files are equipped with reference transcripts but *only some of them*
so far have word-level timestamps (*.OStt) and reference translations (*.TT*).

File formats:
*.wav  ... the input audio file; this is what you will receive for the test set
*.OSt  ... original speech, transcribed
           Manually revised transcripts (derived from AMI corpus annotations).
           One sentence per line, no time stamps.
*.OStt ... original speech, transcribed, timestamped
           Manually revised transcripts (derived from AMI corpus annotations).
           Partial as well as Complete sentences, timestamped with
           the starting and ending time indicating when the words were uttered.
*.TTcs ... text-based translation into Czech
           Reference translation of each of the Complete segments.
           No timestamps are included.
           Some files have *more* references, denoted TTcs1, TTcs2, ...
*.TTde ... text-based translation into German
           Reference translation of each of the Complete segments.
           No timestamps are included.

The OSt files contain occasionally special tags "<NAME>". These tags indicate,
that the original speech was anonymized by *removing* the sound when the
person's real name was uttered.

Additionally, the directory *.sample-outputs contains commented file formats
for your submissions.

All timestamps are in centiseconds.
            
Do not hesitate to contact us if you have any questions.

Ondřej Bojar, bojar@ufal.mff.cuni.cz
Ebrahim Ansari, ansari@ufal.mff.cuni.cz
Sebastian Stüker, sebastian.stueker@kit.edu

2020-03-17
