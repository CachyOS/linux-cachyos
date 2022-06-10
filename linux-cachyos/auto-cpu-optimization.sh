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
elif [[ ${MARCH} == "BDVER1" ]]
then
	MARCH="BULLDOZER"
elif [[ ${MARCH} == "BDVER2" ]]
	MARCH="PILEDRIVER"
then
elif [[ ${MARCH} == "BDVER3" ]]
	MARCH="STEAMROLLER"
then
elif [[ ${MARCH} == "BDVER4" ]]
	MARCH="EXCAVATOR"
then
elif [[ ${MARCH} == "BTVER1" ]]
then
	MARCH="BOBCAT"
elif [[ ${MARCH} == "BTVER2" ]]
	MARCH="JAGUAR"
then
elif [[ ${MARCH} == "AMDFAM10" ]]
	MARCH="MK10"
then
elif [[ ${MARCH} == "K8-SSE3" ]]
	MARCH="K8SSE3"
then
elif [[ ${MARCH} == "BONNELL" ]]
	MARCH="ATOM"
then
elif [[ ${MARCH} == "GOLDMONT-PLUS" ]]
	MARCH="GOLDMONTPLUS"
then
elif [[ ${MARCH} == "SKYLAKE-AVX512" ]]
	MARCH="SKYLAKE2"
then
elif [[ ${MARCH} == "ICELAKE-CLIENT" ]]
	MARCH="ICELAKE"
then
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
