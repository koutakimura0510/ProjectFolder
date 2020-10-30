#!/bin/bash

echo "add > "
echo -n INPUT_STR
read str
git add $str
git commit
git push

exit 0
