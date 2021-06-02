#!/bin/dash

./girt-init >/dev/null
touch a
./girt-add a
./girt-commit -m commit >/dev/null

./girt-branch b1
touch b c
./girt-add b c
./girt-commit -m commit >/dev/null

./girt-checkout b1 >/dev/null
touch b c
./girt-add b
./girt-commit -m commit >/dev/null

output=$(./girt-checkout master 2>&1)
if [ "$(echo $output)" != "girt-checkout: error: Your changes to the following files would be overwritten by checkout: c" ]
then
  echo "failed: girt-checkout: error: Your changes to the following files would be overwritten by checkout: c"
fi
./girt-add c
./girt-commit -m commit >/dev/null

./girt-checkout master >/dev/null

output=$(./girt-merge 2 -m merge 2>&1)
if [ "$output" != "girt-merge: error: can not merge" ]
then
  echo "failed: girt-merge: error: can not merge"
fi
