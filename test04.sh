#!/bin/dash

# test if the file in the target branch is tracked by the current branch but it's not committed yet
# switching branch is safe
./girt-init >/dev/null
touch a
./girt-add a
./girt-commit -m commit0 >/dev/null

./girt-branch b1
./girt-checkout b1 >/dev/null

touch b c
./girt-add b c
./girt-commit -m commit1 >/dev/null

./girt-checkout master >/dev/null
touch b
output=$(./girt-checkout b1 2>&1 | tail -n 1)
if [ "$output" != "b" ]
then
  echo "failed: girt-checkout: error: Your changes to the following files would be overwritten by checkout: b"
fi

touch c
output=$(./girt-checkout b1 2>&1 | tail -n 2)
if [ "$(echo $output)" != "b c" ]
then
  echo "failed: girt-checkout: error: Your changes to the following files would be overwritten by checkout: b c"
fi

./girt-add c
output=$(./girt-checkout b1 2>&1 | tail -n 1)
if [ "$output" != "b" ]
then
  echo "failed: girt-checkout: error: Your changes to the following files would be overwritten by checkout: b"
fi

# since both b and c have been added to the index, you should be able to checkout
./girt-add b
output=$(./girt-checkout b1)
if [ "$output" != "Switched to branch 'b1'" ]
then
  echo "failed: Switched to branch 'b1'"
fi
