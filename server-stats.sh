#!/bin/bash

PORCENTAGEM="CPU%: "
MEMORIA_USADA=$(free '-h' | grep 'Mem' | awk '{print $3}')
MEMORIA_LIVRE=$(free '-h' | grep 'Mem' | awk '{print $4}')
MEMORIA_TOTAL=$(free '-h' | grep 'Mem' | awk '{print $2}' | awk -F 'G' '{print $1}')

while true;
	do echo -n -e '\e[31;1m'$PORCENTAGEM' \e[m' && top '-bn1' | grep '%Cpu(s):' | awk '{print $2}'
	echo -n -e '\e[34;1mMemoria utilizada: \e[m'  && echo $MEMORIA_USADA
	echo -n -e '\e[36;1mMemoria Livre: \e[m' && echo $MEMORIA_LIVRE
	echo -e '\e[36;1mTOP PROCESSOS: \e[m' && top -bn1 | grep -E '[% [0-9]{1,2}[:][0-9]{1,2}[.][0-9]{1,2}*' | head -n 5
	sleep 2
done
