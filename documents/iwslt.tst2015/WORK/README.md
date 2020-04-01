Wed Apr  1 16:24:41 CEST 2020

This is iwslt.tst2015 with multilingual referential subtitles from ted.com.

wavs/ 
	-- source audio, in English, from iwslt.org
FILE_ORDER
	-- from the original package
	
de/
de/tst2015.en.talkid1922.de.json           
	-- downloaded from ted.com/talks/subtitles/id/$TALK_ID/lang/$LANG
	-- suggested by https://arxiv.org/abs/1912.03393
de/tst2015.en.talkid1922.de.txt            
	-- the caption text from json
de/tst2015.en.talkid1922.de.txt.spl-s      
	-- language-specific sentence tokenization with moses-decoder script
de/tst2015.en.talkid1922.de.txt.spl-s.no-par
	-- single words in parentheses removed, because they were e.g. (Laughter), (Applause) etc.
	-- we use this as a reference
...
de/tst2015.en-de.ref.txt                   
	-- if the subtitles of all the documents in testset in this language were available, then their .no-par are concatenated here, in FILE_ORDER


cs/
	-- as above for de
...
cs/tst2015.en.talkid1922.cs.txt.spl-s.no-par.fix-q
	-- fixed quotes into the Czech curly ones
cs/tst2015.en-cs.ref.txt                   
	-- as for de, but .fix-q
	-- we use this as a reference
en/
es/
fr/
hi/
hu/
it/
nl/
pl/
ro/
ru/
sk/
	-- analogically as for de

tst2015.en-cs.ref.txt
tst2015.en-de.ref.txt
tst2015.en-en.ref.txt
tst2015.en-es.ref.txt
tst2015.en-fr.ref.txt
tst2015.en-it.ref.txt
tst2015.en-pl.ref.txt
tst2015.en-ro.ref.txt
tst2015.en-ru.ref.txt
	-- if the subtitles for all the documents in testset were available, then the concatenated reference is here

WORK/
	-- some scripts for downloading and processing the reference
		-- maybe incomplete
		-- may be useful for any other language and TED talks test set
		-- may work only on úfal cluster on Dominik's account (or after you install moses and some other scripts the same way as me)
