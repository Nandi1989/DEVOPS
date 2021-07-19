#!/bin/bash

source components/common.sh

## To remove existing log.
rm -f /tmp/roboshop.log

HEAD "install nginx "
yum install nginx -y  &>>/tmp/roboshop.log
STAT $?

HEAD "download HTDOCS content and deploy under nginx path"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "unzip the downloaded file"
cd /usr/share/nginx/html && rm -rf * && unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* .  && mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log
STAT $?

HEAD "restart ngnix"
systemctl enable nginx && systemctl restart ngnix &>>/tmp/roboshop.log
STAT $?