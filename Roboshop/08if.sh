#!/bin/bash

if [ "abc" == "ABC" ]
then
  echo "equal"
else
  echo "notequal"
fi

#else if example

read -p "enter a number:" number

if [ $number -eq 0 ]; then
  echo "entered number is zero"
elif [ $number -gt 0 ];then
  echo "entered number is positive"
else
  echo "the number is negative"
fi