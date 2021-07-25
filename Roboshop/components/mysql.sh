#!bin/bash

source component/common.sh

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

TEMP_PASS=$(grep 'temporary password' /var/log/mysqld.log)

echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Nandi143$';
uninstall plugin validate_password;" >/tmp/db.sql

echo "show databases" && mysql -u root -p Nandi143$ &>>/tmp/roboshop.log
if [ $? -ne 0 ];then
    HEAD "Change  mysql Password"
    mysql --connect-expired-password -u root -p "${TEMP_PASS}" < /tmp/db.sql &>> /tmp/roboshop.log
    STAT $?
fi

HEAD "Download the archive"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>> /tmp/roboshop.log
STAT $?


HEAD "Load Shipping Schema"
cd /tmp && unzip -o mysql.zip &>> /tmp/roboshop.log && cd mysql-main && mysql -u root -pNandi143$ <shipping.sql  &>> /tmp/roboshop.log
STAT $?