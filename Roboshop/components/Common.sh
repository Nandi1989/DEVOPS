#!/bin/bash

HEAD() {
  echo -n -e "\e[1m $1 \e[0m \t\t ... "
}

STAT() {
  if [ $? -eq 0 ];  then
    echo -e "\e[32m done \e[0m"
  else
    echo -e "\e[31m fail \e[0m"
    echo -e "\e[31m check for more detail ... Log-File : /tmp/roboshop.log \e[0m"
    exit 1
  fi

}