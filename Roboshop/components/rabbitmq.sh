#!/bin/bash

source components/common.sh
rm -rf /tmp/roboshop.log

HEAD "install dependencies for rabbitmq"
yum list installed | grep erlang &>> /tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo "erlang is already installed"
  STAT $?
else
  yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>> /tmp/roboshop.log
  STAT $?
fi

HEAD "install repos for rabbitmq"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash&>> /tmp/roboshop.log
STAT $?

HEAD "install rabbitmq"
yum install rabbitmq-server -y &>> /tmp/roboshop.log
STAT $?

Restart_service "rabbitmq"

HEAD "Create user for rabbitmq"
rabbitmqctl list_users |grep roboshop &>>/tmp/roboshop.log
if [ $? -ne 0 ]; then
 rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log
fi

rabbitmqctl set_user_tags roboshop administrator &>>/tmp/roboshop.log && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log
STAT $?