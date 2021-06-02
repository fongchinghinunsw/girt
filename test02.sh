#!/bin/dash
# test incorrect arguments for commands

if [ "$(./girt-init -n 2>&1)" != "usage: girt-init" ]
then
  echo "failed: usage: girt-init"
fi
if [ "$(./girt-init n 2>&1)" != "usage: girt-init" ]
then
  echo "failed: usage: girt-init"
fi
if [ "$(./girt-init n d 2>&1)" != "usage: girt-init" ]
then
  echo "failed: usage: girt-init"
fi

if [ "$(./girt-add 2>&1)" != "girt-add: error: girt repository directory .girt not found" ]
then
  echo "failed: girt-add: error: girt repository directory .girt not found"
fi
./girt-init >/dev/null

if [ "$(./girt-add 2>&1)" != "usage: girt-add <filenames>" ]
then
  echo "failed: usage: girt-add <filenames>"
fi

if [ "$(./girt-add a 2>&1)" != "girt-add: error: can not open 'a'" ]
then
  echo "failed: girt-add: error: can not open 'a'"
fi

if [ "$(./girt-add a b 2>&1)" != "girt-add: error: can not open 'a'" ]
then
  echo "failed: girt-add: error: can not open 'a'"
fi

# create a file `a`
touch a

# `b` doesn't exist so `a` shouldn't be added to the index
if [ "$(./girt-add a b 2>&1)" != "girt-add: error: can not open 'b'" ]
then
  echo "failed: girt-add: error: can not open 'b'"
fi
if [ "$(./girt-status | grep -E 'a - ')" != "a - untracked" ]
then
  echo "failed: a should be untracked"
fi

# `./` is an incorrect filename so `a` shouldn't be added to the index
if [ "$(./girt-add a ./ 2>&1)" != "girt-add: error: invalid filename './'" ]
then
  echo "failed: girt-add: error: invalid filename './'"
fi
if [ "$(./girt-status | grep -E 'a - ')" != "a - untracked" ]
then
  echo "failed: a should be untracked"
fi

if [ "$(./girt-commit -m 2>&1)" != "usage: girt-commit [-a] -m commit-message" ]
then
  echo "failed: usage: girt-commit [-a] -m commit-message"
fi

if [ "$(./girt-commit "Hi" 2>&1)" != "usage: girt-commit [-a] -m commit-message" ]
then
  echo "failed: usage: girt-commit [-a] -m commit-message"
fi

if [ "$(./girt-commit -m "Hi" "hey" 2>&1)" != "usage: girt-commit [-a] -m commit-message" ]
then
  echo "failed: usage: girt-commit [-a] -m commit-message"
fi

if [ "$(./girt-commit -a "Hi" 2>&1)" != "usage: girt-commit [-a] -m commit-message" ]
then
  echo "failed: usage: girt-commit [-a] -m commit-message"
fi

if [ "$(./girt-commit -m -a "Hi" 2>&1)" != "usage: girt-commit [-a] -m commit-message" ]
then
  echo "failed: usage: girt-commit [-a] -m commit-message"
fi

if [ "$(./girt-commit -a "Hi" -m 2>&1)" != "usage: girt-commit [-a] -m commit-message" ]
then
  echo "failed: usage: girt-commit [-a] -m commit-message"
fi

if [ "$(./girt-log 4 2>&1)" != "usage: girt-log" ]
then
  echo "failed: usage: girt-log"
fi

if [ "$(./girt-show 2>&1)" != "usage: girt-show <commit>:<filename>" ]
then
  echo "failed: usage: girt-show <commit>:<filename>"
fi
