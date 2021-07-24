#!/bin/bash

SOURCE components/common.sh

rm -rf /tmp/roboshop.log

HEAD "Install Rabbitmq"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>> /tmp/roboshop.log
STAT $?

HEAD "Setup YUM repositories"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> /tmp/roboshop.log && # yum install rabbitmq-server -y &>> /tmp/roboshop.log
STAT $?

HEAD "START Rabbitmq"
systemctl enable rabbitmq-server && systemctl start rabbitmq-server &>> /tmp/roboshop.log
STAT $?

HEAD "User Add"
rabbitmqctl add_user roboshop roboshop123 && &>> /tmp/roboshop.log
STAT $?

HEAD "set user tags"
rabbitmqctl set_user_tags roboshop administrator
STAT $?

HEAD "Set set_permissions"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
STAT $?