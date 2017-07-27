#!/bin/bash

#################################################################################
#			Aysad Kozanoglu - Tools
#################################################################################
# Script
#     process_check.sh
# Description
#     Checks the available free space on a disk
# Declare Parameters
#     1) process name
# Usage
#     process_check.sh postfix
#
#################################################################################

# Validate number of arguments

sleeping=10

if [ $# -ne 1 ] ; then
  echo "${DATE} SUNCERTAIN: Invalid number of arguments  Usage: process_running "
  echo "${DATE} SUNCERTAIN: Invalid number of arguments  Usage: process_running " >> /var/log/logtool.log
  exit 1
fi

while true; do

DATE=`date +%Y-%m-%d:%H:%M:%S`

#Checks if the specified process is running
if (( $(ps -ef | grep -v grep | grep $1 | wc -l) > 2 )) 
then
  echo "${DATE} SUCCESS: Process '$1' is running "
  echo "${DATE} SUCCESS: Process '$1' is running " >> /var/log/logtool.log
else
  echo "${DATE} SERROR: Process '$1' is not running"
  echo "${DATE} SERROR: Process '$1' is not running" >> /var/log/logtool.log
fi

sleep $sleeping
done

exit 0
