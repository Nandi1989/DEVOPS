#! /bin/bash

HEAD() {
  echo -n -e "\e[32m $1 \e[0m"
}

STAT() {
  if [ ${1} -eq 0 ]; then
    echo -e "\e[32m done \e[0m"
  else
    echo -e "\e[31m failed , please look at /tmp/roboshop.log file for further details \e[0m"
    exit 1
  fi
}

NodeJS_Install() {
  HEAD "Install nodejs"
  yum install nodejs make gcc-c++ -y &>> /tmp/roboshop.log
  STAT $?

  Useradd
  Unzip_Archive "$1"
  Instal_NPM
  Servicefile_Update "$1"
  Update_Permission
  Component_Restart "$1"
}

Useradd() {
  id roboshop &>> /tmp/roboshop.log
  if [ "$?" -eq 0 ]; then
    echo "User already exists" &>> /tmp/roboshop.log
    STAT $?
  else
    useradd roboshop &>> /tmp/roboshop.log
    STAT $?
  fi
}

Unzip_Archive() {
  HEAD "Download catalogue archive"
  curl -s -L -o /tmp/$1.zip "https://github.com/roboshop-devops-project/$1/archive/main.zip" &>> /etc/roboshop.log
  STAT $?

  cd /home/roboshop && unzip /tmp/$1.zip && mv $1-main $1  && cd /home/roboshop/$1 &>> /etc/roboshop.log
  STAT $?
}

Instal_NPM(){
  npm install --unsafe perm &>> /etc/roboshop.log
  STAT $?
}

Servicefile_Update() {
  HEAD "Update IP address of MONGODB Server in systemd.service "
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal' -e 's/DBHOST/mysql.roboshop.internal'  /home/roboshop/$1/systemd.service &>> /tmp/roboshop.log
  STAT $?

  HEAD "Move the service file"
  mv /home/roboshop/$1/systemd.service /etc/systemd/system/$1.service  &>> /etc/roboshop.log
  STAT $?
}

Update_Permission(){
HEAD "permission to roboshop user"
chown roboshop:roboshop /home/roboshop -R
STAT $?
}

Component_Restart() {
  HEAD "Restart the service $1"
  systemctl daemon-reload && systemctl start $1 && systemctl enable $1 &>> /etc/roboshop.log
  STAT $?
}

