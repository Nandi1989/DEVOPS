#!/bin/bash

component=$1

## component name check
if [ -z ${component} ];  then
    echo -e "\e[31m component name is needed \e[0m"
    exit 1
fi

##LTID=lt-0bc9e6d40bf1e5c3c
##LTIDVER=2

##INSTANCE_CREATE() {
##  aws ec2 describe-instances --filters "name=tag:Name,values=${component}"


}

if
