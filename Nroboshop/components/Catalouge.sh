#! /bin/bash

source Nroboshop/components/common.sh

HEAD "Install Node js"
yum install nodejs make gcc -c++ -y && useradd roboshop && switchuser roboshop &>> /etc/roboshop.log
STAT $?

HEAD "Install npm"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" && cd /home/roboshop &>> /etc/roboshop.log
unzip /tmp/ctatlouge.zip && move catalogue-main catalogue && cd /home/roboshop/catalogue && Install npm &>> /etc/roboshop.log
STAT $?

HEAD "switch user to Root user and complete Catalogue"
sudo su && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service  &>> /etc/roboshop.log
systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue &>> /etc/roboshop.log
STAT $?
