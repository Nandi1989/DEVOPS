#!/bin/bash

COMPONENT=$1

## component name check
if [ -z ${COMPONENT} ];  then
    echo -e "\e[31m component name is needed \e[0m"
    exit 1
fi

LID=lt-0bae2d44a42501107
LVER=1


DNS_UPDATE() {
  PRIVATEIP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}"  | jq .Reservations[].Instances[].PrivateIpAddress | xargs -n1)
  sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATEIP}/" record.json >/tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id Z031396221895VDGBP6VC --change-batch file:///tmp/record.json | jq

}

INSTANCE_CREATE() {
  INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name | xargs -n1)

  if [ "${INSTANCE_STATE}" = "running" ]; then
    echo "Instance already exists"
    DNS_UPDATE
    return 0
  fi

  if [ "${INSTANCE_STATE}" = "stopped" ]; then
    echo "Instance already exists"
    return 0
  fi

  echo -n Instance ${COMPONENT} created - IPADDRESS is
  aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq | grep  PrivateIpAddress  |xargs -n1
  sleep 30
  DNS_UPDATE

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


