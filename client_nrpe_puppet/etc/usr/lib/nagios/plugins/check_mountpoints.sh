#!/bin/bash
# Author: Aysad Kozanoglu

MOUNT_POINTS=("192.168.1.10:/mnt/NFSPOINT1" "192.168.1.11:/mnt/NFSBACKUPPOINT")
   DF_MOUNTS=$(df -h)

#debug array
#printf "%s\n" "${MOUNT_POINTS[@]}"

END_RESULT=""

for CHECK_MOUNTPOINT in "${MOUNT_POINTS[@]}"
do
	MOUNT_RESULT=$(echo $DF_MOUNTS | grep $CHECK_MOUNTPOINT)
	if [ -z $MOUNT_RESULT ]
 	  then
	    END_RESULT="NO MOUNT for "$CHECK_MOUNTPOINT"\n"$END_RESULT
	fi
done

# RETURN CHECK RESULT
echo -e $END_RESULT

if [ "$END_RESULT" = "NFS MOUNTPOINTS OK" ]
  then
	exit 0
  else
	exit 2
fi
