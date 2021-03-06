#!/bin/bash

COMPONENT=$1

if [ -z ${COMPONENT} ];then
  echo -e "\e[31m value of COMPONENT IS empty\e[0m"
  exit 1
fi

LID=lt-0e4a9279d9989f510


update_DNS() {
  IPADDRESS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].PrivateIpAddress | xargs -n1)
  sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${IPADDRESS}/" record.json > /tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id Z031396221895VDGBP6VC --change-batch file:///tmp/record.json | jq

}


INSTANCE_CREATE() {
  INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name | xargs -n1)
  if [ "${INSTANCE_STATE}" = "running" ];then
     echo "Instance is already existing"
     update_DNS
     sleep 30
     return 0
  elif [ "${INSTANCE_STATE}" = "stopped" ];then
    echo "Instance state is Stopped"
    return 0
  else
    echo "either instance terminated or not yet created"
    aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=1 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"
    update_DNS
  fi
}


if [ "$1" = "all" ];then
  for instance in Frontend mongodb cart catalogue mysql payment rabbitmq redis shipping user ; do
    COMPONENT=${instance}
    INSTANCE_CREATE
  done
else
    COMPONENT=$1
    INSTANCE_CREATE
fi
