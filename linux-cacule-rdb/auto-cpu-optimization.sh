#!/bin/bash
CPU=$(gcc -Q -march=native --help=target|grep march=|awk '{print $2}'|head -1)
MARCH=$(echo $CPU|tr '[:lower:]' '[:upper:]'&&echo)
if [[ ${MARCH} == "ZNVER1" ]]; then
    MARCH="ZEN"
elif [[ ${MARCH} == "ZNVER2" ]]; then
    MARCH="ZEN2"
elif [[ ${MARCH} == "ZNVER3" ]]; then
    MARCH="ZEN3"
elif [[ ${MARCH} == "BDVER1" ]]; then
    MARCH="BULLDOZER"
elif [[ ${MARCH} == "BDVER2" ]]; then
    MARCH="PILEDRIVER"
elif [[ ${MARCH} == "BDVER3" ]]; then
    MARCH="STEAMROLLER"
elif [[ ${MARCH} == "BDVER4" ]]; then
    MARCH="EXCAVATOR"
elif [[ ${MARCH} == "BTVER1" ]]; then
    MARCH="BOBCAT"
elif [[ ${MARCH} == "BTVER2" ]]; then
    MARCH="JAGUAR"
elif [[ ${MARCH} == "AMDFAM10" ]]; then
    MARCH="MK10"
elif [[ ${MARCH} == "K8-SSE3" ]]; then
    MARCH="K8SSE3"
elif [[ ${MARCH} == "BONNELL" ]]; then
    MARCH="ATOM"
elif [[ ${MARCH} == "GOLDMONT-PLUS" ]]; then
    MARCH="GOLDMONTPLUS"
elif [[ ${MARCH} == "SKYLAKE-AVX512" ]]; then
    MARCH="SKYLAKE2"
elif [[ ${MARCH} == "MIVYBRIDGE" ]]; then
    scripts/config --disable CONFIG_AGP_AMD64 
    scripts/config --disable CONFIG_MICROCODE_AMD
    MARCH="MIVYBRIDGE"
elif [[ ${MARCH} == "ICELAKE-CLIENT" ]]; then
    MARCH="ICELAKE"
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
