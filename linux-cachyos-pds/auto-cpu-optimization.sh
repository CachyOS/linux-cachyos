#!/bin/bash
CPU=$(gcc -Q -march=native --help=target|grep mtune=|awk '{print $2}'|head -1)
MARCH=$(echo $CPU|tr '[:lower:]' '[:upper:]'&&echo)
echo
echo "----------------------------------"
echo "| APPLYING AUTO-CPU-OPTIMIZATION |"
echo "----------------------------------"
echo "[*] DETECTED CPU (MARCH) : $MARCH"
sed -i "/CONFIG_GENERIC_CPU=y/d;s/\# CONFIG_M$MARCH is not set/CONFIG_M$MARCH=y/g" .config
sleep 3&&echo
