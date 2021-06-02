#!/bin/dash
# test girt-commit -a with rm

./girt-init >/dev/null
touch a b
output=$(./girt-commit -a -m commit)
if [ "$output" != "nothing to commit" ]
then
  echo "failed: nothing to commit"
fi

./girt-add a
echo Arigato >a
output=$(./girt-commit -a -m commit)
if [ "$output" != "Committed as commit 0" ]
then
  echo "failed: Committed as commit 0"
fi

rm a
output=$(./girt-commit -a -m commit)
if [ "$output" != "Committed as commit 1" ]
then
  echo "failed: Committed as commit 1"
fi