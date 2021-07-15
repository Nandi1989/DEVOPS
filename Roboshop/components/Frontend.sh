#!/bin/bash

source components/Common.sh

rm -f /tmp/roboshop.log

HEAD "Install nginx"
  yum install nginx -y &>> /tmp/roboshop.log
STAT $?

HEAD "Download HTDOCS content from GITHUB"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>/tmp/roboshop.log
STAT $?

HEAD "Remove html files "
rm -rf /usr/share/nginx/html/*
STAT $?

HEAD "Extract HTDOCS content"
unzip -d /usr/share/nginx/html/ /tmp/frontend.zip &>>/tmp/roboshop.log
mv /usr/share/nginx/html/frontend-main/* /usr/share/nginx/html/. &>>/tmp/roboshop.log
mv /usr/share/nginx/html/static/* /usr/share/nginx/html/. &>>/tmp/roboshop.log
STAT $?

HEAD "Move conf file"
mv /usr/share/nginx/html/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT $?

HEAD "Restart nginx"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log
STAT $?
