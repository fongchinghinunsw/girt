#!/bin/dash

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
./girt-checkout b1
echo ".."
./girt-add b
./girt-checkout b1 
echo ".."
./girt-commit -m commit >/dev/null
./girt-checkout b1
./girt-checkout master >/dev/null

echo ".."
echo Man >>b
./girt-add b
echo Guten Tag >>b
./girt-checkout b1
