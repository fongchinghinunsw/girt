#!/bin/dash
# test girt-log/show works fine when there are >= 10 commits

./girt-init >/dev/null
touch a
./girt-add a
./girt-commit -m "commit1" >/dev/null

touch b
./girt-add b
./girt-commit -m "commit2" >/dev/null

touch c
./girt-add c
./girt-commit -m "commit3" >/dev/null

echo "Hi" >a
./girt-add a
./girt-commit -m "commit4" >/dev/null

echo "Hello" >b
./girt-add b
./girt-commit -m "commit5" >/dev/null

echo "Howdy\n" >c
./girt-add c
./girt-commit -m "commit6" >/dev/null

./girt-rm --cached a
./girt-add a
output=$(./girt-commit -m "commit7")
if [ "$output" != "nothing to commit" ]
then
  echo "failed: nothing to commit"
fi

./girt-rm b
output=$(./girt-add b 2>&1)
if [ "$output" != "girt-add: error: can not open 'b'" ]
then
  echo "failed: girt-add: error: can not open 'b'"
fi
./girt-commit -m "commit8" >/dev/null

echo "Oh crap" >c
output=$(./girt-rm c 2>&1)
if [ "$output" != "girt-rm: error: 'c' in the repository is different to the working file" ]
then
  echo "girt-rm: error: 'c' in the repository is different to the working file"
fi

echo "Oh crap" >c
./girt-add c
./girt-commit -m "commit9" >/dev/null

echo "Aha" >c
./girt-rm --cached c
./girt-add c
./girt-commit -m "commit10" >/dev/null

rm c
./girt-add a
output=$(./girt-commit -m "commit11")
if [ "$output" != "nothing to commit" ]
then
  echo "failed: nothing to commit"
fi

touch d
./girt-add d
output=$(./girt-rm d 2>&1)
if [ "$output" != "girt-rm: error: 'd' has staged changes in the index" ]
then
  echo "failed: girt-rm: error: 'd' has staged changes in the index"
fi
./girt-commit -m "commit12" >/dev/null

touch d
./girt-add d
./girt-commit -m "commit13" >/dev/null

touch e
./girt-add e
./girt-commit -m "commit14" >/dev/null

touch f
./girt-add f
./girt-commit -m "commit15" >/dev/null

output=$(./girt-show :a)
if [ "$output" != "Hi" ]
then
  echo "failed: Hi"
fi
output=$(./girt-show :b 2>&1)
if [ "$output" != "girt-show: error: 'b' not found in index" ]
then
  echo "failed: girt-show: error: 'b' not found in index"
fi
output=$(./girt-show :c)
if [ "$output" != "Aha" ]
then
  echo "failed: Aha"
fi
output=$(./girt-show :d)
if [ "$output" != "" ]
then
  echo "failed: "
fi
output=$(./girt-show :e)
if [ "$output" != "" ]
then
  echo "failed: "
fi
output=$(./girt-show :f)
if [ "$output" != "" ]
then
  echo "failed: "
fi

output=$(./girt-show 0:a)
if [ "$output" != "" ]
then
  echo "failed: "
fi

output=$(./girt-show 0:b 2>&1)
if [ "$output" != "girt-show: error: 'b' not found in commit 0" ]
then
  echo "failed: girt-show: error: 'b' not found in commit 0"
fi

output=$(./girt-show 1:a)
if [ "$output" != "" ]
then
  echo "failed: "
fi

output=$(./girt-show 1:b)
if [ "$output" != "" ]
then
  echo "failed: "
fi

output=$(./girt-show 4:a)
if [ "$output" != "Hi" ]
then
  echo "failed: Hi"
fi

output=$(./girt-show 4:b)
if [ "$output" != "Hello" ]
then
  echo "failed: Hello"
fi
output=$(./girt-show 7:a)
if [ "$output" != "Hi" ]
then
  echo "failed: Hi"
fi
output=$(./girt-show 7:b 2>&1)
if [ "$output" != "girt-show: error: 'b' not found in commit 7" ]
then
  echo "failed: girt-show: error: 'b' not found in commit 7"
fi

# check if the commits are sorted correct
output=$(./girt-log | head -n 3)
if [ "$(echo $output)" != "11 commit15 10 commit14 9 commit12" ]
then
  echo "failed: incorrect log"
fi