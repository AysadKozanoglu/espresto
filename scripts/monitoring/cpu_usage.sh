#!/bin/bash
#################################################################################
#  		Aysad Kozanoglu - Tools 
#################################################################################
# Script
#     cpu_usage.sh
# Description
#     Checks CPU usage on the computer.
# Declare Parameters
#     1) nMaxCpuUsage (number) - maximum allowed CPU usage (%)
# Usage
#     cpu_usage.sh nMaxCpuUsage
# Sample
#     cpu_usage.sh 70
#################################################################################


nMaxCpuUsage=$1
sleeping=10
while true; do
DATE=`date +%Y-%m-%d:%H:%M:%S`
# Validate number of arguments
if [ $# -ne 1 ] ; then
  echo "${DATE} UNCERTAIN: Invalid number of arguments - Usage: cpu nMaxCpuUsage"
  echo "${DATE} UNCERTAIN: Invalid number of arguments - Usage: cpu nMaxCpuUsage" >> /var/log/logtool.log
  exit 1
fi

# Validate numeric parameter nMaxCpuUsage
regExpNumber='^[0-9]+$'
if ! [[ $1 =~ $regExpNumber ]] ; then
  echo "${DATE} UNCERTAIN: Invalid argument: nMaxCpuUsage (number expected)"
  echo "${DATE} UNCERTAIN: Invalid argument: nMaxCpuUsage (number expected)" >> /var/log/logtool.log
  exit 1
fi

# Check the CPU usage
nCpuLoadPercentage=`ps -A -o pcpu | tail -n+2 | paste -sd+ | bc`
nCpuLoadPercentage=$( echo "$nCpuLoadPercentage / 1" | bc )

if [ $nCpuLoadPercentage -le $nMaxCpuUsage ] ; then
  echo "${DATE} SUCCESS: CPU usage is [$nCpuLoadPercentage%], minimum allowed=[$1%] DATA:$nCpuLoadPercentage"
  echo "${DATE} SUCCESS: CPU usage is [$nCpuLoadPercentage%], minimum allowed=[$1%] DATA:$nCpuLoadPercentage" >> /var/log/logtool.log
else
  echo "${DATE} ERROR: CPU usage is [$nCpuLoadPercentage%], minimum allowed=[$1%] DATA:$nCpuLoadPercentage"
  echo "${DATE} ERROR: CPU usage is [$nCpuLoadPercentage%], minimum allowed=[$1%] DATA:$nCpuLoadPercentage" >> /var/log/logtool.log
fi
sleep $sleeping
done 
exit 0
