#! /bin/bash

source components/common.sh

HEAD "setup mongodb repository"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
STAT $?

HEAD  "Install Mongo & Start Service"
yum install -y mongodb -org  && enable mongodb &>>/tmp/roboshop.log
STAT $?

HEAD "Update Liste IP address from 127.0.0.1 to 0.0.0.0 in config file"
sed 's/127.0.0.1/0.0.0.0' && systemctl restat mongodb &>> /tmp/roboshop.log
STAT $?

HEAD "Download the schema and load it."
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" && cd /temp. &>>roboshop.log
unzip mongodb.zip && cd mongodb-main && mongo < catalogue.js && mongo < users.js &>> /tmp/roboshop.log
STAT $?

