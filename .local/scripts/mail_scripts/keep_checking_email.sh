#!/bin/bash

# To enable mbsync write anything on the file $ENABLE_MBSYNC
# To disable mbsync make $ENABLE_MBSYNC an empty file

ENABLE_MBSYNC=/home/jose/.enable_mbsync
FILE=/home/jose/.unread_email
DIR=/home/jose/Mail/unm/Inbox/new

while [ 1 ]; do
  # python ~/.local/scripts/UnseenMail/UnseenMail.py
  if [ -s $ENABLE_MBSYNC ]; then mbsync -a; fi
  echo ' '> $FILE
  ls $DIR | wc -l | xargs >> $FILE
  sleep 15;
done;
