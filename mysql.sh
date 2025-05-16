#!/bin/bash

USERID=(id -u)

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
    echo "mysql is not installed. going to install it"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then 
        echo "installing mysql is SUCCESS"
    else 
        echo "installing mysql is FAILURE"
        exit 1
    fi        
else
    echo "mysql is already installed..."
fi

dnf list installed python3
if [ $? -ne 0 ]
then 
    echo "pyhton is not installed. going to install it"
    dnf install python3 -y
    if [ $? -ne 0 ]
        echo "installing python3 is SUCCESS"
    
    else
        echo "installing python3 is FAILURE"
        exit 1
    fi
else
    echo "python3 is already installed"
fi    
