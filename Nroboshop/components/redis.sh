#!/bin/bash

HEAD "INSTALL REDIS"
  yum install epel-release yum-utils -y &>> roboshop.log
STAT $?

HEAD "INSTALL REDIS"
  yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>> roboshop.log
STAT $?

HEAD "INSTALL REDIS"
  yum-config-manager --enable remi &>> roboshop.log
  yum install redis -y &>> roboshop.log
STAT $?

