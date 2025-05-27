#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if days are provided then variable 3 will be considered other-wise by default 14days will be considered

if [ $USERID -ne 0 ]
then 
    echo -e "$R ERROR:: Please run this script using root access $N"
    exit 1
else
    echo "you are running with root access"
fi

USAGE(){
    echo -e "$R USAGE:: $N sh backup.sh <Source-dir> <Destination-dir> <Days(optional)>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then 
    echo -e "$R source directory $SOURCE_DIR does not exist, Please check $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then 
    echo -e "$R source directory $DEST_DIR does not exist, Please check $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z "$FILES" ]   # if $FILES not empty, code gets executed
then                 
    echo "Files to zip are: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip" #zip files name
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f $ZIP_FILE ]  # to check if the zipping is successful or not
    then
        echo -e "$G Successfully created the zip file"
        while IFS= read -r filepath #once the zipping is done, to delete the log files we use this code
        do 
            echo "Deleting file: $filepath"
            rm -rf $filepath
        done <<< $FILES
        echo -e "log files older then $DAYS from source directory removed.... $G SUCCESSFULLY $N"
    else 
        echo -e "zip file creation is... $R failure $N"
        exit 1
    fi
else 
    echo -e "no log files found older then 14days... $Y SKIPPING $N"
fi


