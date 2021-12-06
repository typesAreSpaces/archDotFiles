#!/bin/bash

get_status() {
  result=' OFF '
  OBSPID=`ps ax | awk '\$5=="obs"{print \$1}'`
  for pid in $OBSPID; do
    file=`readlink -f /proc/$pid/fd/14`
    if grep '==== Streaming St' "$file" | tail -1 | grep -q 'Streaming Start' ; then
      result=' LIVE '
      break
    fi
    if grep '==== Recording St' "$file" | tail -1 | grep -q 'Recording Start' ; then
      result=' REC '
      break
    fi
  done
  echo $result
}

if [ "$1" = '--once' ] ; then
  get_status
  exit
fi

while :; do
  get_status
  sleep 1
done
