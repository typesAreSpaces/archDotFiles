#!/bin/bash

get_status() {
  result=' OFF '
  start_prefix='Starting rec\|Recording Start'
  OBSPID=`ps ax | awk '\$5=="obs"{print \$1}'`
  for pid in $OBSPID; do
    file=`readlink -f /proc/$pid/fd/10`
    if grep '==== Streaming St' "$file" | tail -1 | grep -q 'Streaming Start' ; then
      result=' LIVE '
      break
    fi
    if grep '==== Recording St' "$file" | tail -1 | grep -q 'Recording Start' ; then
      result=' REC '
      tmp1_start_date=`grep "$start_prefix" "$file" | tail -1 | awk '{print \$1, \$2}'`
      tmp1_end_date=`date +%r`
      tmp2_start_date=${tmp1_start_date:0:11}
      tmp2_end_date=${tmp1_end_date:0:11}
      start_date=$(date -u -d "$tmp2_start_date" +"%s")
      end_date=$(date -u -d "$tmp2_end_date" +"%s")
      duration=`date -u -d "0 $end_date sec - $start_date sec" +"%H:%M:%S"`
      result+="($duration)"
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
