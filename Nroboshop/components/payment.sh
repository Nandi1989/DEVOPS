#!/bin/bash

SOURCE component/common.sh

rm -rf /tmp/roboshop.log

HEAD "Install Python"
yum install python36 gcc python3-devel -y &>> /tmp/roboshop.log
STAT $?

useradd
Unzip_Archive "payment"

Note: command may fail with permission denied, So run as root user
HEAD "Install the dependencies"
cd /home/roboshop/payment &>> /tmp/roboshop.log && pip3 install -r requirements.txt &>> /tmp/roboshop.log
STAT $?

Component_Restart "payment"