#!/bin/bash

# SOURCE_DIR=/home/ec2-user/app-logs
# FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

# while IFS= read -r line
# do
#   echo "Deleting the file: $line"
#   rm -rf $line
# done <<< $FILES_TO_DELETE

# echo "Script executed successfully"

SOURCE_DIR=/home/ec2-user/app-logs

while IFS= read -r line
do
    echo "$line"
done <<< SOURCE_DIR