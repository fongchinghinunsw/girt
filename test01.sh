#!/bin/dash
# testing files with filenames that contain characters other than alphanumeric character

./girt-init >/dev/null
touch 'a.-_' '0.-_'
./girt-add 'a.-_' '0.-_'

# test files with special names get added to the index correctly.
if [ "$(./girt-show :a.-_ 2>&1)" != "" -o "$(./girt-show :0.-_ 2>&1)" != "" ]
then
  echo "failed: file is not added to the index"
  exit 1
fi

if [ "$(./girt-show :A.-_ 2>&1)" !=  "girt-show: error: 'A.-_' not found in index" ]
then
  echo "failed: error is not shown properly"
  exit 1
fi

./girt-commit -m "God saves the queen" >/dev/null

if [ "$(./girt-show 0:a.-_ 2>&1)" != "" -o "$(./girt-show 0:0.-_ 2>&1)" != "" ]
then
  echo "failed: file is not committed"
  exit 1
fi

if [ "$(./girt-show 3:a 2>&1)" != "girt-show: error: unknown commit '3'" -o "$(./girt-show 1:a 2>&1)" != "girt-show: error: unknown commit '1'" ]
then
  echo "failed: wrong error"
  exit 1
fi

if [ "$(./girt-show 0:a 2>&1)" != "girt-show: error: 'a' not found in commit 0" ]
then
  echo "failed: wrong error"
  exit 1
fi
