#!/bin/bash

SOURCE components/common.sh

rm -rf /tmp/roboshop.log

HEAD "install Maven"
yum install maven -y &>> /tmp/roboshop.log
STAT $?

Useradd

Unzip_Archive "shipping"

HEAD "clean MVN"
mvn clean package &>> /tmp/roboshop.log && mv target/shipping-1.0.jar shipping.jar &>> /tmp/roboshop.log
STAT $?

Servicefile_Update "shipping"

Component_Restart "shipping"
