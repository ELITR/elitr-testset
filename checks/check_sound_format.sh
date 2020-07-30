#!/bin/bash
#checks for sound files stored directly in the repo

cd "${0%/*}/.."
exit_code=0

#wav files shouldn't be included directly, use .link or .url
for wav in `find ./documents -name "*.wav*"`; do
	length=${#wav}
	length=$((length-3))
	extension=${wav:$length:3}
	if [[ $extension == "wav" || $extension == "WAV" ]]; then
		echo "ERROR: File $wav can't be stored in the repository"
		exit_code=1
	fi
done

exit $exit_code
