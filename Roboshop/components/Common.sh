#!/bin/bash

HEAD() {
  echo -n " $1 \t\t\t ..."
}

STAT() {
  if [ $? -eq 0 ];  then
    echo -e "\e[31m done \e[0m"
  else
    echo -e "\e[31m fail \e[0m"
  fi

}