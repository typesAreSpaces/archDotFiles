#!/bin/bash
currentkey=$(cat ~/scripts/currentvars/currentkey)
if [ ${currentkey} == "be" ]
then
   echo a ${currentkey} a
   setxkbmap ru
   echo ru > ~/scripts/currentvars/currentkey
elif  [ ${currentkey} == "ru" ]
then
   echo a ${currentkey} a
   setxkbmap be 
   echo be > ~/scripts/currentvars/currentkey
fi

