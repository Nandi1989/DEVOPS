#!/bin/bash

source components/Common.sh

rm -f /tmp/roboshop.log

HEAD "Install nodejs"
yum install nodejs make gcc-c++ -y &>> /tmp/roboshop.log
STAT $?

HEAD "Add user"
id roboshop &>> /tmp/roboshop.log
if [ $? -eq 0 ]; then
  echo "user exists"
else
  useradd roboshop &>> /tmp/roboshop.log
fi
STAT $?

HEAD "download from App from  github"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
STAT $?

HEAD "Extract the archive"
cd /home/roboshop && unzip /tmp/catalogue.zip && mv catalogue-main catalogue && cd /home/roboshop/catalogue
STAT $?

HEAD "Install npm"
sudo npm install
STAT $?

HEAD "Update the  IP address"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
STAT $?

HEAD "Restart the service"
systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue
STAT $?
