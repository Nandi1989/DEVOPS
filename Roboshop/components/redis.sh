#!/bin/bash

source components/Common.sh
rm -rf /tmp/roboshop.log

HEAD "Setup Redis Repo"
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>> /tmp/roboshop.log && yum-config-manager --enable remi  &>> /tmp/roboshop.log
STAT $?

HEAD "Install Redis"
yum install redis -y
STAT $?

HEAD "Update Listen Address in Redis Config"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
STAT $?

Restart_service "redis"