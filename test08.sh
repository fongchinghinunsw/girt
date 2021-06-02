#!/bin/dash

./girt-init >/dev/null
touch a b
./girt-add a b
output=$(./girt-rm a 2>&1)
if [ "$output" != "girt-rm: error: 'a' has staged changes in the index" ]
then
  echo "failed: girt-rm: error: 'a' has staged changes in the index"
fi

./girt-commit -m commit >/dev/null
./girt-branch b1

./girt-rm a
./girt-rm --cached b
output=$(./girt-show :a 2>&1)

if [ "$output" != "girt-show: error: 'a' not found in index" ]
then
  echo "failed: girt-show: error: 'a' not found in index"
fi
output=$(cat a 2>&1)

if [ "$output" != "cat: a: No such file or directory" ]
then
  echo "failed: cat: a: No such file or directory"
fi
output=$(./girt-show :b 2>&1)

if [ "$output" != "girt-show: error: 'b' not found in index" ]
then
  echo "failed: girt-show: error: 'b' not found in index"
fi
output=$(cat b)
if [ "$output" != "" ]
then
  echo "failed: "
fi

# file `a` shouldn't appears in the working directory and the index when checkout
./girt-checkout b1 >/dev/null
output=$(./girt-show :a 2>&1)
if [ "$output" != "girt-show: error: 'a' not found in index" ]
then
  echo "failed: girt-show: error: 'a' not found in index"
fi
output=$(cat a 2>&1)
if [ "$output" != "cat: a: No such file or directory" ]
then
  echo "failed: cat: a: No such file or directory"
fi
# file `b` shouldn't appears in the index when checkout
output=$(./girt-show :b 2>&1)

if [ "$output" != "girt-show: error: 'b' not found in index" ]
then
  echo "failed: girt-show: error: 'b' not found in index"
fi
output=$(cat b)
if [ "$output" != "" ]
then
  echo "failed: empty content"
fi

