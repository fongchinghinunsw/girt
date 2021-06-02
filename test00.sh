#!/bin/dash

# test simple merge commit

./girt-init >/dev/null
touch a
./girt-add a
./girt-commit -m commit0 >/dev/null

./girt-branch b1 >/dev/null
./girt-checkout b1 >/dev/null

touch b
./girt-add b
./girt-commit -m commit1 >/dev/null

touch c
./girt-add c
./girt-commit -m commit2 >/dev/null

./girt-checkout master >/dev/null
./girt-branch b2 >/dev/null
./girt-checkout b2 >/dev/null

touch d
./girt-add d
./girt-commit -m commit3 >/dev/null
./girt-checkout master >/dev/null

touch d

error_msg=$(./girt-merge 3 -m merge0 2>&1)
exit_status=$?
if [ "$error_msg" != "girt-merge: error: can not merge" ]
then
  echo "failed: should raise an error"
fi
if [ "$exit_status" -ne 1 ]
then
  echo "failed: wrong exit status"
fi

rm d

msg=$(./girt-merge 3 -m merge0)
if [ "$msg" != "Fast-forward: no commit created" ]
then
  echo "Should be fast-forward"
fi

log=$(./girt-log)
if [ "$(echo $log)" != "3 commit3 0 commit0" ]
then
  echo "failed: incorrect log"
fi