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
systemctl enable mysqld &>>/tmp/roboshop.log && systemctl start mysqld &>> /tmp/roboshop.log
STAT $?

temppass=$(grep 'a temporary password' /var/log/mysqld.log | awk '{print $NF}')
echo "echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';
uninstall plugin validate_password;" >/tmp/db.sql"

echo show database | mysql -uroot -pRoboshop@1 &>>/tmp/roboshop.log

if [ $? -ne 0 ];then
  echo"echo password need to be changed"
  mysql --connect-expired-password -uroot -p"${temppass}" </tmp/db.sql &>>/tmp/roboshop.log
  STAT $?
fi

HEAD "Download schema"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
STAT $?

HEAD "Load schema services"
cd /tmp && unzip mysql.zip && cd mysql-main &>> /tmp/roboshop.log && mysql -u root -ppassword <shipping.sql &>> /tmp/roboshop.log
STAT $?

