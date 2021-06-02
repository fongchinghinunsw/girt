#!/bin/dash

./girt-init
echo hello >a
./girt-add a
./girt-commit -m commit-A
./girt-branch b1
echo world >>a
./girt-checkout b1