#!/bin/bash

source components/Common.sh

HEAD "setup MongoDB repo"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
STAT $?

HEAD "Install MongoDB"
yum install -y mongodb-org &>> /tmp/roboshop.log
STAT $?


HEAD
systemctl enable mongod &>> /tmp/roboshop.log
systemctl start mongod &>> /tmp/roboshop.log
STAT $?

HEAD "start MongoDB"
systemctl enable mongod &>> /tmp/roboshop.log
systemctl start mongod &>> /tmp/roboshop.log
STAT $?

