#! /usr/bin/bash

OBSPID=`ps ax | awk '\$5=="obs"{print \$1}'`

for pid in $OBSPID; do
  echo "Current pid $pid"
  path="/proc/$pid/fd"
  for x in $(ls "$path"); do
    echo $x "---" $(readlink -f "$path/$x")
  done;
done;
