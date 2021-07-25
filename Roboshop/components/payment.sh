#!/bin/bash

source components/common.sh
rm -rf /tmp/roboshop.log

HEAD "Install python"
yum install python36 gcc python3-devel -y &>> /tmp/roboshop.log
STAT $?

ADD_USER
Download_Unzip_Archive "payment"

HEAD "Install dependencies"
cd /home/roboshop/payment & pip3 install -r requirements.txt &>> /tmp/roboshop.log
STAT $?

USER_ID=$(id -u roboshop)
GROUP_ID=$(id -g roboshop)

HEAD "Update App Configuration"
sed -i -e "/uid/ c uid=${USER_ID}" -e "/gid/ c gid=${GROUP_ID}" /home/roboshop/payment/payment.ini
STAT $?

Restart_service "payment"