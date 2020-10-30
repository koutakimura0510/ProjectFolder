#!/bin/bash

echo -n "add > "
read str
git add $str
git commit
git push

exit 0
