#!/bin/bash
CPU=$(gcc -Q -march=native --help=target|grep mtune=|awk '{print $2}'|head -1)
MARCH=$(echo $CPU|tr '[:lower:]' '[:upper:]'&&echo)
if [[ ${MARCH} == "ZNVER" ]]
then
	MARCH="ZEN"

elif [[ ${MARCH} == "ZNVER2" ]]
then
	MARCH="ZEN2"

elif [[ ${MARCH} == "ZNVER3" ]]
then
	MARCH="ZEN3"

elif [[ ${MARCH} == "BDVER2" ]]
then
	MARCH="MPILEDRIVER"
fi
MARCH2=M${MARCH}
echo
echo "----------------------------------"
echo "| APPLYING AUTO-CPU-OPTIMIZATION |"
echo "----------------------------------"
echo "[*] DETECTED CPU (MARCH) : ${MARCH2}"
scripts/config -k --disable CONFIG_GENERIC_CPU
scripts/config -k --enable CONFIG_${MARCH2}
sleep 3&&echo
