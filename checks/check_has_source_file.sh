#! /bin/bash

cd "${0%/*}/.."
exit_code=0
root_dir="./documents"

for file in `find "$root_dir" -name "*.TT*" -not -path "*output*"`; do
	ost=`echo $file | sed 's/TT.*/OSt/g'`
	missing=$(find $ost 2>&1)
	if [[ $missing == *"No such file"* ]]; then
		echo "ERROR: file" $file "does not have a source file, such as .OSt"
		exit_code=1
	fi
done

exit $exit_code
