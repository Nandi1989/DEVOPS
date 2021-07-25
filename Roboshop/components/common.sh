#!/bin/bash

HEAD() {
  echo -n -e "\e[1m $1 \e[0m \t\t ... "
}

STAT() {
  if [ $? -eq 0 ];  then
    echo -e "\e[32m done \e[0m"
  else
    echo -e "\e[31m fail \e[0m"
    echo -e "\e[31m check for more detail ... Log-File : /tmp/roboshop.log \e[0m"
    exit 1
  fi

}


NodeJS_Install() {
  HEAD "Install nodejs"
  yum install nodejs make gcc-c++ -y &>> /tmp/roboshop.log
  STAT $?

  ADD_USER
  Download_Unzip_Archive $1
  NPM_INSTALL
  IP_Update_systemd $1
  Permission_Update
  Restart_service $1
}


ADD_USER() {
  HEAD "Add user"
  id roboshop &>> /tmp/roboshop.log
  if [ $? -eq 0 ]; then
    echo "user exists"
    STAT $?
  else
    useradd roboshop &>> /tmp/roboshop.log
    STAT $?
  fi
}



Download_Unzip_Archive() {
  HEAD "download from App from  github"
  curl -s -L -o /tmp/$1.zip "https://github.com/roboshop-devops-project/$1/archive/main.zip"  &>> /tmp/roboshop.log
  STAT $?

  HEAD "Extract the archive"
  cd /home/roboshop && unzip /tmp/$1.zip && mv $1-main $1 && cd /home/roboshop/$1  &>> /tmp/roboshop.log
  STAT $?

}

NPM_INSTALL(){
  HEAD "Install npm"
  sudo npm install --unsafe-perm  &>> /tmp/roboshop.log
  STAT $?
}

IP_Update_systemd(){
  HEAD "Update the  IP address"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTHOST/cart.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/' /home/roboshop/$1/systemd.service  && mv /home/roboshop/$1/systemd.service /etc/systemd/system/$1.service
  STAT $?
}

Permission_Update(){
  chown roboshop:roboshop /home/roboshop -R  &>> /tmp/roboshop.log
}

Restart_service(){
  HEAD "Restart the $1 service"
  systemctl daemon-reload && systemctl start catalogue && systemctl enable $1  &>> /tmp/roboshop.log
  STAT $?
}