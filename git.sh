#!/bin/bash

echo -n "add > "
read str
git add $str

echo -n "commit > "
read str
git commit -m "$str"

git push origin master

exit 0
