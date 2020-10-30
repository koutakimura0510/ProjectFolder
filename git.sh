#!/bin/bash

echo -n "add > "
read str

if [ -d ./$str ]; then
	git add $str
else
	echo "名前が違うか、ファイル／ディレクトリが存在しません"
	exit 1
fi

echo -n "commit > "
read str
git commit -m "$str"

git push origin master

exit 0
