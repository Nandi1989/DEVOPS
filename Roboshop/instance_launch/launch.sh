#!/bin/bash

component=$1

## component name check
if [ -z ${component} ];  then
    echo "\e[31m component name is needed \[0m"
    exit 1
fi

##LTID=
##LTIDVER=

##INSTANCE_CREATE() {
##  aws ec2 describe-instances --filters "name=tag:Name,values=${component}"


}

if
