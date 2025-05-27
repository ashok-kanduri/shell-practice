#!/bin/bash

ASHOK="/home/ec2-user/shell-practice/ashok"

while IFS= read -r line
do
  echo %line
done < $ASHOK
