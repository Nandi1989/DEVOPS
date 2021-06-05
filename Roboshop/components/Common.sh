#!/bin/bash

HEAD() {
  echo -n "\e[32m $1 \e[0m \t\t"
}

STAT() {
  if [ $? -eq 0 ];  then
    echo -e "\e[31m done[0m"
  else
    echo -e "\e[31m fail [0m"
  fi

}