#! /bin/bash

HEAD() {
  echo -n -e "\e[32m $1 \e[0m"
}

STAT() {
  if [ ${1} -eq 0 ]; then
    echo -e "\e[32m done \e[0m"
  else
    echo -e "\e[31m failed , please look at /tmp/roboshop.log file for further details \e[0m"
    exit 1
  fi
}