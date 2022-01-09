#!/bin/bash

#######################################
#        AUTO-CPU-OPTIMIZATION        #
#######################################
#      CREATOR : BL4CKH47H4CK3R       #
#######################################
#  HTTPS://GITHUB.COM/BL4CKH47H4CK3R  #
#######################################

CPU=`gcc -Q -march=native --help=target | grep march | awk '{print $2}' | head -1`
MARCH=`echo ${CPU} | tr '[:lower:]' '[:upper:]'`&& echo

if [[ ${MARCH} == "ZNVER" ]]
then
	MARCH="ZEN"

elif [[ ${MARCH} == "ZNVER2" ]]
then
	MARCH="ZEN2"

elif [[ ${MARCH} == "ZNVER3" ]]
then
	MARCH="ZEN3"
fi

echo "----------------------------------"
echo "| APPLYING AUTO-CPU-OPTIMIZATION |"
echo "----------------------------------"
echo "[*] DETECTED CPU (MARCH) : ${MARCH}"
sed -i "/CONFIG_GENERIC_CPU=y/d;s/\# CONFIG_M${MARCH} is not set/CONFIG_M${MARCH}=y/g" .config
sleep 3 && echo
