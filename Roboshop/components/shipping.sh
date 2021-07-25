#!/bin/bash

source /components/common.sh
rm -rf /tmp/roboshop.log

HEAD "Install Maven"
yum install maven -y &>> /tmp/roboshop.log
STAT $?

APP_USER_ADD
Download_Unzip_Archive "shipping"

HEAD "Make Application package"
mvn clean package && mv target/shipping-1.0.jar shipping.jar &>> /tmp/roboshop.log
STAT $?

IP_Update_systemd "shipping"
Restart_service "shipping"