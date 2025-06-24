#!/bin/bash

CPU_PERCENT="CPU%: "

while true;
	do

	#The memory in human readable
	USED_MEMORY_H=$(free -h | grep 'Mem' | awk '{print $3}')
	FREE_MEMORY_H=$(free -h | grep 'Mem' | awk '{print $4}')

	declare -i USED_MEMORY=$(free | grep 'Mem' | awk '{print $3}')
	declare -i FREE_MEMORY=$(free | grep 'Mem' | awk '{print $4}')
	declare -i TOTAL_MEMORY=$(free | grep 'Mem' | awk '{print $2}')

	declare -i TOTAL_DISK=$(dmesg | grep -E "blocks" | awk -F '(' '{print $2}' | tr '/|)' ' ' | head -n 1 | awk '{print $1}''{print $2}' | sed -n '1p')
	TOTAL_DISK_UNITY=$(dmesg | grep -E "blocks" | awk -F '(' '{print $2}' | tr '/|)' ' ' | head -n 1 | awk '{print $1}''{print $2}' | sed -n '2p')

	declare -i USED_DISK=$(dmesg | grep -E "blocks" | awk -F '(' '{print $2}' | tr '/|)' ' ' | head -n 1 | awk '{print $3}''{print $4}' | sed -n '1p')
	USED_DISK_UNITY=$(dmesg | grep -E "blocks" | awk -F '(' '{print $2}' | tr '/|)' ' ' | head -n 1 | awk '{print $3}''{print $4}' | sed -n '2p')

	USED_MEMORY_PERCENT=$(echo "scale=2; $USED_MEMORY / $TOTAL_MEMORY" | bc)
	FREE_MEMORY_PERCENT=$(echo "scale=2; $FREE_MEMORY / $TOTAL_MEMORY" | bc)

	#Conversion TOTAL DISK Unity to bytes

	if [ "$TOTAL_DISK_UNITY" = "GB" ]; then MULTI=$(echo "$TOTAL_DISK * 1000000000" | bc )
#		echo $MULTI

	elif [ "$TOTAL_DISK_UNITY" = "MB" ]; then MULTI=$(echo "$TOTAL_DISK * 1000000" | bc )
#		echo $MULTI

	elif [ "$TOTAL_DISK_UNITY" = "KB" ]; then MULTI=$(echo "$TOTAL_DISK * 1000" | bc )
#		echo $MULTI

	fi

	#Conversion USED DISK Unity to bytes

	if [ "$USED_DISK_UNITY" = "GB" ]; then MULTI_USED=$(echo "$USED_DISK * 1000000000" | bc )
#                echo $MULTI_USED

        elif [ "$USED_DISK_UNITY" = "MB" ]; then MULTI_USED=$(echo "$USED_DISK * 1000000" | bc )
#                echo $MULTI_USED

        elif [ "$USED_DISK_UNITY" = "KB" ]; then MULTI_USED=$(echo "$USED_DISK * 1000" | bc )
#                echo $MULTI_USED

        fi

	echo -n -e '\n''\e[31;1m'$CPU_PERCENT' \e[m' && top '-bn1' | grep '%Cpu(s):' | awk '{print $2}'
	echo -n -e '\e[34;1mUsed Memory: \e[m' &&  echo -n $USED_MEMORY_H " " && echo $USED_MEMORY_PERCENT'%' | sed -E 's/.//'
	echo -n -e '\e[36;1mFree Memory: \e[m' && echo -n $FREE_MEMORY_H " " && echo $FREE_MEMORY_PERCENT'%' | sed -E 's/.//'
	echo -e '\n''\e[36;1mTop most CPU usage process: \e[m' && top -bn1 -o %CPU | grep -E '[% [0-9]{1,2}[:][0-9]{1,2}[.][0-9]{1,2}*' | head -n 5
	echo -e '\n''\e[36;1mTop most Memory usage process: \e[m' && top -bn1 -o %MEM | grep -E '[% [0-9]{1,2}[:][0-9]{1,2}[.][0-9]{1,2}*' | head -n 5
	sleep 2


done

