#!/bin/bash
source components/common.sh

rm -f /tmp/roboshop.log
set-hostname redis

HEAD "INSTALL REDIS"
#  yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>> /tmp/roboshop.log
  yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>/tmp/roboshop.log
STAT $?

HEAD "INSTALL REDIS"
  yum-config-manager --enable remi && yum install redis -y &>> /tmp/roboshop.log
STAT $?

HEAD "modify the IP address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
STAT $?

Component_Restart "redis"