#!/bin/bash

CPU_PERCENT="CPU%: "

while true;
	do

	#The memory in human readable

	USED_MEMORY_H=$(free -h | grep 'Mem' | awk '{print $3}')
	FREE_MEMORY_H=$(free -h | grep 'Mem' | awk '{print $4}')

	#Some variables to get memory in bytes

	declare -i USED_MEMORY=$(free | grep 'Mem' | awk '{print $3}')
	declare -i FREE_MEMORY=$(free | grep 'Mem' | awk '{print $4}')
	declare -i TOTAL_MEMORY=$(free | grep 'Mem' | awk '{print $2}')

	#Divide the memory to get the percentage of use

	USED_MEMORY_PERCENT=$(echo "scale=2; $USED_MEMORY / $TOTAL_MEMORY" | bc)
	FREE_MEMORY_PERCENT=$(echo "scale=2; $FREE_MEMORY / $TOTAL_MEMORY" | bc)

	#Print CPU, Memory Free and Used Memory

	echo -n -e '\n''\e[33;1m'$CPU_PERCENT'\e[m' && top '-bn1' | grep '%Cpu(s):' | awk '{print $2}'
	echo -n -e '\e[33;1mUsed Memory: \e[m' &&  echo -n $USED_MEMORY_H " " && echo $USED_MEMORY_PERCENT'%' | sed -E 's/.//'
	echo -n -e '\e[33;1mFree Memory: \e[m' && echo -n $FREE_MEMORY_H " " && echo $FREE_MEMORY_PERCENT'%' | sed -E 's/.//'

	sleep 1

	#Print the CPU top 5 processes and Memory top 5 processes

	echo -e '\n''\e[44;36;1mTop Most CPU Usage Processes: \e[m' && top -bn1 -o %CPU | grep -E '[% [0-9]{1,2}[:][0-9]{1,2}[.][0-9]{1,2}*' | head -n 5
	echo -e '\n''\e[44;36;1mTop Most Memory Usage Processes: \e[m' && top -bn1 -o %MEM | grep -E '[% [0-9]{1,2}[:][0-9]{1,2}[.][0-9]{1,2}*' | head -n 5

	sleep 1

	#Print the Disk %

	echo -e '\n''\e[42;37;1mAll Partitions and Disk Usage: \e[m'
	df -H
	sleep 3

done

