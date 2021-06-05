#!/bin/bash

source components/Common.sh

HEAD "Install nginx"
yum install nginx -y
STAT $?

HEAD "Start nginx"
systemctl enable nginx
systemctl start nginx
STAT $?

