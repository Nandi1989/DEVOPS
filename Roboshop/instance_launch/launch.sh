#!/bin/bash

COMPONENT=$1

## component name check
if [ -z ${COMPONENT} ];  then
    echo -e "\e[31m component name is needed \e[0m"
    exit 1
fi

LID=lt-0bc9e6d40bf1e5c3c
LVER=2


INSTANCE_CREATE() {
aws ec2 desc


  aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"

}

if [ "$1" == "all" ]; then
  for ins_name in Frontend mongodb catalogue redis user cart mysql shipping rabbitmq payment ; do
    COMPONENT=$ins_name
    INSTANCE_CREATE
    done
else
  COMPONENT=$1
  INSTANCE_CREATE
fi


