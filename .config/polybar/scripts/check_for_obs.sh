#! /usr/bin/bash

for x in $(ls /proc/28914/fd); do
  echo $x "---" $(readlink -f "/proc/28914/fd/$x")
done;
