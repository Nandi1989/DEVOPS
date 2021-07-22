#!/bin/bash

source components/common.sh

rm -rf /tmp/roboshop.log

HEAD "Install Mysql"
  echo '[mysql57-community]
  name=MySQL 5.7 Community Server
  baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
  enabled=1
  gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT $?

HEAD "Install mysql community"
yum remove mariadb-libs -y && yum install mysql-community-server -y &>> /tmp/roboshop.log
STAT $?

HEAD "Systemctl Mysql"
systemctl enable mysqld && systemctl start mysqld &>> /tmp/roboshop.log
STAT $?

#HEAD "search for temporary password"
#temppass=$(grep 'a temporary password' /var/log/mysqld.log | awk '{print $NF}')


