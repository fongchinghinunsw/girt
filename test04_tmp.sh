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
./girt-checkout b1
echo ".."
touch c
./girt-checkout b1

echo ".."
./girt-add c
./girt-checkout b1
# since both b and c have been added to the index, you should be able to checkout
./girt-add b
./girt-checkout b1