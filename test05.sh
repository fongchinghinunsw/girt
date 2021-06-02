#!/bin/dash
# test girt-checkout prevent overwitten

./girt-init >/dev/null
touch a
./girt-add a
./girt-commit -m commit0 >/dev/null

./girt-branch b1 >/dev/null
./girt-checkout b1 >/dev/null
touch b
./girt-add b
./girt-commit -m commit1 >/dev/null

./girt-checkout master >/dev/null
echo Hey >b
output=$(./girt-checkout b1 2>&1)
if [ "$(echo $output)" != "girt-checkout: error: Your changes to the following files would be overwritten by checkout: b" ]
then
  echo "failed: girt-checkout: error: Your changes to the following files would be overwritten by checkout: b"
fi

./girt-add b
output=$(./girt-checkout b1 2>&1)
if [ "$(echo $output)" != "girt-checkout: error: Your changes to the following files would be overwritten by checkout: b" ]
then
  echo "failed: girt-checkout: error: Your changes to the following files would be overwritten by checkout: b"
fi
./girt-commit -m commit >/dev/null

output=$(./girt-checkout b1)
if [ "$(echo $output)" != "Switched to branch 'b1'" ]
then
  echo "failed: Switched to branch 'b1'"
fi
./girt-checkout master >/dev/null

echo Man >>b
./girt-add b
echo Guten Tag >>b
output=$(./girt-checkout b1 2>&1)
if [ "$(echo $output)" != "girt-checkout: error: Your changes to the following files would be overwritten by checkout: b" ]
then
  echo "failed: girt-checkout: error: Your changes to the following files would be overwritten by checkout: b"
fi
