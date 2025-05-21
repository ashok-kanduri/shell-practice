#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then 
    echo -e "$R ERROR:: please run the script with root access $N"
    exit 1 #give other than 0 upto 127
else 
    echo "you are running with root access"
fi

#validate functions input as exit status,for the command they tried to install.
VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo -e "$G installing $2 is SUCCESSFULL $N"
    else 
        echo -e "$R installing $2 is FAILED $N"
        exit 1
    fi
        
}

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "mysql is not installed... going to install it now"
    dnf install mysql -y
    VALIDATE $? "mysql"
else 
    echo -e "$Y mysql is already INSTALLED $N"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo "python3 is not installed... going to install it now"
    dnf install python3 -y
    VALIDATE $? "python3"
else 
    echo -e "$Y python3 is already INSTALLED $N"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install it now"
    dnf install nginx -y
    VALIDATE $? "nginx"
else 
    echo -e "$Y nginx is already INSTALLED $N"
fi