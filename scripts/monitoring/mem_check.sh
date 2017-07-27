#################################################################################
#  			Aysad Kozanoglu - tools 
#################################################################################
# Script
#     memory.sh
# Description
#     Checks memory usage on the computer.
# Declare Parameters
#     1) nMaxMemoryUsage (number) - maximum allowed CPU usage (%)
# Usage
#     memory.sh nMaxMemoryUsage
# Sample
#     memory.sh 80
#################################################################################
clear
nMaxMemoryUsage=$1
sleeping=10

while true; do
DATE=`date +%Y-%m-%d:%H:%M:%S`
# Validate number of arguments
if [ $# -ne 1 ] ; then
  echo "${DATE} UNCERTAIN: Invalid number of arguments - Usage: memory nMaxMemoryUsage"
  echo "${DATE} UNCERTAIN: Invalid number of arguments - Usage: memory nMaxMemoryUsage" >> /var/log/logtool.log
  exit 1
fi

# Validate numeric parameter nMaxMemoryUsage
regExpNumber='^[0-9]+$'
if ! [[ $1 =~ $regExpNumber ]] ; then
  echo "${DATE} UNCERTAIN: Invalid argument: nMaxMemoryUsage (number expected)"
  echo "${DATE} UNCERTAIN: Invalid argument: nMaxMemoryUsage (number expected)" >> /var/log/logtool.log
  exit 1
fi

# Check the memory usage
nMemoryPercentage=`ps -A -o pmem | tail -n+2 | paste -sd+ | bc`
nMemoryPercentage=$( echo "$nMemoryPercentage / 1" | bc )

if [ $nMemoryPercentage -le $nMaxMemoryUsage ] ; then
  echo "${DATE} SUCCESS: Memory usage is [$nMemoryPercentage%], minimum allowed=[$1%] DATA:$nMemoryPercentage"
  echo "${DATE} SUCCESS: Memory usage is [$nMemoryPercentage%], minimum allowed=[$1%] DATA:$nMemoryPercentage" >> /var/log/logtool.log
else
  echo "${DATE} ERROR: Memory usage is [$nMemoryPercentage%], minimum allowed=[$1%] DATA:$nMemoryPercentage"
  echo "${DATE} ERROR: Memory usage is [$nMemoryPercentage%], minimum allowed=[$1%] DATA:$nMemoryPercentage" >> /var/log/logtool.log
fi
sleep $sleeping
done 
exit 0
