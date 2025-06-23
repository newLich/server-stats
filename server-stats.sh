#!/bin/bash

PORCENTAGEM="CPU%: "

MEMORIA_USADA_H=$(free -h | grep 'Mem' | awk '{print $3}')
MEMORIA_LIVRE_H=$(free -h | grep 'Mem' | awk '{print $4}')

typeset -i MEMORIA_USADA=$(free | grep 'Mem' | awk '{print $3}')
typeset -i MEMORIA_LIVRE=$(free | grep 'Mem' | awk '{print $4}')
typeset -i MEMORIA_TOTAL=$(free | grep 'Mem' | awk '{print $2}')

while true;
	do

	MEMORIA_USADA_PORCENTAGEM=$(echo "scale=2; $MEMORIA_USADA / $MEMORIA_TOTAL" | bc)
	MEMORIA_LIVRE_PORCENTAGEM=$(echo "scale=2; $MEMORIA_LIVRE / $MEMORIA_TOTAL" | bc)

	echo -n -e '\n''\e[31;1m'$PORCENTAGEM' \e[m' && top '-bn1' | grep '%Cpu(s):' | awk '{print $2}'
	echo -n -e '\e[34;1mMemoria utilizada: \e[m' &&  echo -n $MEMORIA_USADA_H " " && echo $MEMORIA_USADA_PORCENTAGEM'%' | sed -E 's/.//'
	echo -n -e '\e[36;1mMemoria Livre: \e[m' && echo -n $MEMORIA_LIVRE_H " " && echo $MEMORIA_LIVRE_PORCENTAGEM'%' | sed -E 's/.//'
	echo -e '\n''\e[36;1mTop Processos CPU: \e[m' && top -bn1 -o %CPU | grep -E '[% [0-9]{1,2}[:][0-9]{1,2}[.][0-9]{1,2}*' | head -n 5
	echo -e '\n''\e[36;1mTop Processos MEMORIA: \e[m' && top -bn1 -o %MEM | grep -E '[% [0-9]{1,2}[:][0-9]{1,2}[.][0-9]{1,2}*' | head -n 5
	sleep 2

done
