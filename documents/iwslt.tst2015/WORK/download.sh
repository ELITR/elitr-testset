#for lang in de cs sk hu en pl ro nl fr ; do
#for lang in es ; do
#for lang in it ru ; do
for lang in hi; do
	mkdir -p $lang
	for t in `cat ../FILE_ORDER`; do
		a=${t/*talkid/}
		echo $a
		curl https://www.ted.com/talks/subtitles/id/$a/lang/$lang > $lang/$t.$lang.json
	done
done

