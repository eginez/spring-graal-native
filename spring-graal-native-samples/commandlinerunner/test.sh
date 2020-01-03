#!/usr/bin/env bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

EXECUTABLE=${PWD##*/}
echo "Testing $EXECUTABLE output"

./target/${EXECUTABLE} > target/native-image/test-output.txt 2>&1 &
PID=$!
sleep 3

if [[ $1 != "-s" ]]; then  # enable silent mode to avoid the below 
    BUILDTIME=`cat target/native-image/output.txt | grep "\[total\]" | sed 's/^.*\[total\]: *//' | tr -d -c 0-9\.`
    echo "Image build time: ${BUILDTIME}ms"
    RSS=`ps -o rss ${PID} | tail -n1`
    RSS=`bc <<< "scale=1; ${RSS}/1024"`
    echo "RSS memory: ${RSS}M"
    SIZE=`wc -c <"./target/${EXECUTABLE}"`/1024
    SIZE=`bc <<< "scale=1; ${SIZE}/1024"`
    echo "Image size: ${SIZE}M"
    STARTUP=`cat target/native-image/test-output.txt | grep "JVM running for"`
    REGEXP="Started .* in ([0-9\.]*) seconds \(JVM running for ([0-9\.]*)\).*$"
    if [[ ${STARTUP} =~ ${REGEXP} ]]; then
      STIME=${BASH_REMATCH[1]}
      JTIME=${BASH_REMATCH[2]}
      echo "Startup time: ${STIME} (JVM running for ${JTIME})"
    fi
fi


if [[ `cat target/native-image/test-output.txt | grep "commandlinerunner running!"` ]]
then
  printf "${GREEN}SUCCESS${NC}\n"
  echo `date +%Y%m%d-%H%M`,$EXECUTABLE,$BUILDTIME,${RSS},${SIZE},${STIME},${JTIME}  > target/native-image/summary.csv
  kill ${PID}
  exit 0
else
  cat target/native-image/output.txt
  cat target/native-image/test-output.txt
  printf "${RED}FAILURE${NC}: the output of the application does not contain the expected output\n"
  kill ${PID}
  exit 1
fi
