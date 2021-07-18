#!/bin/bash

COMPONENT=$1

if [ -z ${COMPONENT} ];then
  echo "value of COMPONENT IS empty"
  exit
fi

LID=i-04f089715ed156371
LVER=2

INSTANCE_CREATE() {
 INSTANCE_STATE=$(aws ec2 describe-instnaces --filters "name=tag:name,values=${COMPONENT}"--sg-09436406187809d28
echo "Instances"


}