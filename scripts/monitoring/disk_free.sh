#!/bin/bash
#################################################################################
#  			Aysad Kozanoglu -Tools: 
#################################################################################
# Script
#     disk-free.sh
# Description
#     Checks the available free space on a disk
# Declare Parameters
#     1) sDrive (string) - Mounted drive
#     2) nMinFreeMB (number) - Minimum free space
# Usage
#     disk-free.sh sDrive nMinFreeMB
# Sample
#     bash ./disk-free.sh /dev/sda1 1000
#################################################################################

# This script is based on the 'df' command
# df -T output is like this:
# Filesystem     Type     1K-blocks    Used Available Use% Mounted on
# udev           devtmpfs   2001860       0   2001860   0% /dev
# tmpfs          tmpfs       403844   26368    377476   7% /run
# /dev/sda1      ext4     126820132 3797080 116557928   4% /
# tmpfs          tmpfs      2019208     156   2019052   1% /dev/shm
# tmpfs          tmpfs         5120       0      5120   0% /run/lock
# tmpfs          tmpfs      2019208       0   2019208   0% /sys/fs/cgroup
# cgmfs          tmpfs          100       0       100   0% /run/cgmanager/fs
# tmpfs          tmpfs       403844      64    403780   1% /run/user/1000
clear

sDrive=$1
nMinFreeMB=$2
sleeping=10
while true; do
DATE=`date +%Y-%m-%d:%H:%M:%S`
# Validate number of arguments
if [ $# -ne 2 ] ; then
  echo "${DATE} UNCERTAIN: Invalid number of arguments - Usage: disk-free-mb sDrive nMinFreeMB"
  echo "${DATE} UNCERTAIN: Invalid number of arguments - Usage: disk-free-mb sDrive nMinFreeMB" >> /var/log/logtool.log
  exit 1
fi

# Validate numeric parameter nMinFreeMB
regExpNumber='^[0-9]+$'
if ! [[ $2 =~ $regExpNumber ]] ; then
  echo "${DATE} UNCERTAIN: Invalid argument: nMinFreeMB (number expected)"
  echo "${DATE} UNCERTAIN: Invalid argument: nMinFreeMB (number expected)" >> /var/log/logtool.log
  exit 1
fi

# Execute a command like this (assuming /dev/sda1). Note that slashes need to be escaped in AWK:
# df -T | awk '/\/dev\/sda1/ { print $5; }'
sDriveEsc=`echo $sDrive | sed 's/\//\\\\\//g'`        # e.g.: "\/dev\/sda1" <- "/dev/sda1"
sCommand="df -T | awk '/$sDriveEsc/ { print \$5; }'"  # e.g.: df -T | awk '/\/dev\/sda1/ { print $5; }'

# Get number of free blocks (1K)
nBlocksFree=`eval $sCommand`
if [ -z "$nBlocksFree" ]; then
  echo "${DATE} UNCERTAIN: Drive [$sDrive] does not exist"
  echo "${DATE} UNCERTAIN: Drive [$sDrive] does not exist" >> /var/log/logtool.log
  exit 1
fi

# Get number of free MB (assuming a block is 1K)
let nMBFree="nBlocksFree/1024"

# Print final result. ActiveXperts will interpret the line, expected format is like this:
# [SUCCESS|ERROR|UNCERTAIN]  DATA:[]
if [ $nMBFree -ge $nMinFreeMB ] ; then
  echo "${DATE}  SUCCESS: Free disk space $sDrive=[$nMBFree MB], minimum required=[$nMinFreeMB MB] DATA:$nMBFree"
  echo "${DATE}  SUCCESS: Free disk space $sDrive=[$nMBFree MB], minimum required=[$nMinFreeMB MB] DATA:$nMBFree" >> /var/log/logtool.log
else
  echo "${DATE} ERROR: Free disk space $sDrive=[$nMBFree MB], minimum required=[$nMinFreeMB MB] DATA:$nMBFree"
  echo "${DATE} ERROR: Free disk space $sDrive=[$nMBFree MB], minimum required=[$nMinFreeMB MB] DATA:$nMBFree" >> /var/log/logtool.log
fi	
sleep $sleeping
done
# Exit script
exit 0
