#!/bin/dash
# test girt-commit -a with girt-rm

./girt-init >/dev/null
touch a

# girt-rm removes the file from the index, so girt-commit -a shouldn't work
./girt-add a
./girt-rm --cached a
output=$(./girt-commit -a -m commit)
if [ "$output" != "nothing to commit" ]
then
  echo "failed: nothing to commit"
fi

./girt-add a
output=$(./girt-rm a 2>&1)
if [ "$output" != "girt-rm: error: 'a' has staged changes in the index" ]
then
  echo "failed: girt-rm: error: 'a' has staged changes in the index"
fi
output=$(./girt-commit -a -m commit)
if [ "$output" != "Committed as commit 0" ]
then
  echo "Committed as commit 0"
fi
