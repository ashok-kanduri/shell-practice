#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "ERROR:: please run the script with root access"
    exit 1
else 
    echo "you are running with root access"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "mysql is not installed... going to install it now"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then 
        echo "installing mysql is SUCCESSFULL"
    else 
        echo "installing mysql is FAILED"
        exit 1
    fi
else 
    echo "mysql is already INSTALLED"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo "python3 is not installed... going to install it now"
    dnf install python3 -y
    if [ $? -eq 0 ]
    then 
        echo "installing python3 is SUCCESSFULL"
    else 
        echo "installing python3 is FAILED"
        exit 1
    fi
else 
    echo "python3 is already INSTALLED"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install it now"
    dnf install nginx -y
    if [ $? -eq 0 ]
    then 
        echo "installing nginx is SUCCESSFULL"
    else 
        echo "installing nginx is FAILED"
        exit 1
    fi
else 
    echo "nginx is already INSTALLED"
fi