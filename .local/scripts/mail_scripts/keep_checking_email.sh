#!/bin/bash

FILE=/home/jose/.unread_email
DIR=/home/jose/Mail/unm/Inbox/new

while [ 1 ]; do
  # python ~/.local/scripts/UnseenMail/UnseenMail.py
  mbsync -a
  echo ' '> $FILE
  ls $DIR | wc -l | xargs >> $FILE
  sleep 15;
done;
