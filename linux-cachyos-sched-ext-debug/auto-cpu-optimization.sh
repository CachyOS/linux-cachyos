#!/bin/bash

# Check if GCC is installed
check_gcc() {
  if ! [ -x "$(command -v gcc)" ]; then
    # Display error message if GCC is not installed
    echo "Error: GCC is not installed. Please install GCC and try again." >&2
    exit 1
  fi
}

# Call the function before running the rest of the script
check_gcc

# Get CPU type from GCC and convert to uppercase
MARCH=$(gcc -Q -march=native --help=target|grep -m1 march=|awk '{print toupper($2)}')

# Check for specific CPU types and set MARCH variable accordingly
case $MARCH in
  ZNVER1) MARCH="ZEN";;
  ZNVER2) MARCH="ZEN2";;
  ZNVER3) MARCH="ZEN3";;
  ZNVER4) MARCH="ZEN4";;
  BDVER1) MARCH="BULLDOZER";;
  BDVER2) MARCH="PILEDRIVER";;
  BDVER3) MARCH="STEAMROLLER";;
  BDVER4) MARCH="EXCAVATOR";;
  BTVER1) MARCH="BOBCAT";;
  BTVER2) MARCH="JAGUAR";;
  AMDFAM10) MARCH="MK10";;
  K8-SSE3) MARCH="K8SSE3";;
  BONNELL) MARCH="ATOM";;
  GOLDMONT-PLUS) MARCH="GOLDMONTPLUS";;
  SKYLAKE-AVX512) MARCH="SKYLAKEX";;
  MIVYBRIDGE)
    scripts/config --disable CONFIG_AGP_AMD64 
    scripts/config --disable CONFIG_MICROCODE_AMD
    MARCH="MIVYBRIDGE";;
  ICELAKE-CLIENT) MARCH="ICELAKE";;
esac

# Add "M" prefix to MARCH variable
MARCH2=M${MARCH}

# Display detected CPU and apply optimization
echo "----------------------------------"
echo "| APPLYING AUTO-CPU-OPTIMIZATION |"
echo "----------------------------------"
echo "[*] DETECTED CPU (MARCH) : ${MARCH2}"
scripts/config -k --disable CONFIG_GENERIC_CPU
scripts/config -k --enable CONFIG_${MARCH2}
