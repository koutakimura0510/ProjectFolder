#!/bin/bash

echo -n "add Directory ('.' all add) > "
read str


if [ -d ./$str ]; then
	git add $str
	
else
	echo "名前が違うか、ディレクトリが存在しません"
	exit 1
fi

echo -n "commit msg > "
read str

git commit -m "$str"

git push origin master

exit 0
