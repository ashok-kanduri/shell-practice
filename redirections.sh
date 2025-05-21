#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

# &>> --> shows detail output in logs file
# tee --> shows minimum output on screen

mkdir -p $LOGS_FOLDER
echo "script started executed at $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then 
    echo -e "$R ERROR:: please run the script with root access $N" | tee -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else 
    echo "you are running with root access" | tee -a $LOG_FILE
fi

#validate functions input as exit status,for the command they tried to install.
VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo -e "$G installing $2 is SUCCESSFULL $N" | tee -a $LOG_FILE
    else 
        echo -e "$R installing $2 is FAILED $N" | tee -a $LOG_FILE
        exit 1
    fi
        
}

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "mysql is not installed... going to install it now" | tee -a $LOG_FILE
    dnf install mysql -y
    VALIDATE $? "mysql"
else 
    echo -e "$Y mysql is already INSTALLED $N" | tee -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "python3 is not installed... going to install it now" | tee -a $LOG_FILE
    dnf install python3 -y
    VALIDATE $? "python3"
else 
    echo -e "$Y python3 is already INSTALLED $N" | tee -a $LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install it now" | tee -a $LOG_FILE
    dnf install nginx -y
    VALIDATE $? "nginx"
else 
    echo -e "$Y nginx is already INSTALLED $N" | tee -a $LOG_FILE
fi