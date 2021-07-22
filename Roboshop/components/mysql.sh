#!bin/bash

source component/Common.sh

rm -rf /tmp/roboshop.log

HEAD "Setup MySQL Repo"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT $?

HEAD "install MySQL"
yum remove mariadb-libs -y &>> /tmp/roboshop.log && yum install mysql-community-server -y &>> /tmp/roboshop.log
STAT $?

Restart_service "mysql"

TEMP_PASS=$(grep 'temporary password' )