for i in */*.json ; do
	t=${i/.json/.txt}
	jq -r '.captions[].content' < $i > $t || rm $t
done
