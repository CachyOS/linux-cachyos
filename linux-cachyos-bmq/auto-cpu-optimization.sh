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
MARCH=$(gcc -Q -march=native --help=target|grep -m1 march=|awk '{print $2}')

# Sync with 0005-cachy.patch using
# sed -E '/= -march=/!d;/^[+]/!d;/CONFIG_GENERIC_CPU/d;/-march=native/d;s/.+CONFIG_M([^)]+).+-march=([^ ]+).*/\2) MARCH=\1;;/g' 0005-cachy.patch

# Check for specific CPU types and set MARCH variable accordingly
case $MARCH in
  bonnell) MARCH=ATOM;;
  k8-sse3) MARCH=K8SSE3;;
  amdfam10) MARCH=K10;;
  barcelona) MARCH=BARCELONA;;
  btver1) MARCH=BOBCAT;;
  btver2) MARCH=JAGUAR;;
  bdver1) MARCH=BULLDOZER;;
  bdver2) MARCH=PILEDRIVER;;
  bdver3) MARCH=STEAMROLLER;;
  bdver4) MARCH=EXCAVATOR;;
  znver1) MARCH=ZEN;;
  znver2) MARCH=ZEN2;;
  znver3) MARCH=ZEN3;;
  znver4) MARCH=ZEN4;;
  znver5) MARCH=ZEN5;;
  nehalem) MARCH=NEHALEM;;
  westmere) MARCH=WESTMERE;;
  silvermont) MARCH=SILVERMONT;;
  goldmont) MARCH=GOLDMONT;;
  goldmont-plus) MARCH=GOLDMONTPLUS;;
  sandybridge) MARCH=SANDYBRIDGE;;
  ivybridge) MARCH=IVYBRIDGE;;
  haswell) MARCH=HASWELL;;
  broadwell) MARCH=BROADWELL;;
  skylake) MARCH=SKYLAKE;;
  skylake-avx512) MARCH=SKYLAKEX;;
  cannonlake) MARCH=CANNONLAKE;;
  icelake-server) MARCH=ICELAKE_SERVER;;
  icelake-client) MARCH=ICELAKE_CLIENT;;
  cascadelake) MARCH=CASCADELAKE;;
  cooperlake) MARCH=COOPERLAKE;;
  tigerlake) MARCH=TIGERLAKE;;
  sapphirerapids) MARCH=SAPPHIRERAPIDS;;
  rocketlake) MARCH=ROCKETLAKE;;
  alderlake) MARCH=ALDERLAKE;;
  raptorlake) MARCH=RAPTORLAKE;;
  meteorlake) MARCH=METEORLAKE;;
  emeraldrapids) MARCH=EMERALDRAPIDS;;
esac

# If doesn't match, re-use the arch name (uppercased) 

# Display detected CPU and apply optimization
echo "----------------------------------"
echo "| APPLYING AUTO-CPU-OPTIMIZATION |"
echo "----------------------------------"
echo "[*] DETECTED CPU (MARCH) : ${MARCH}"
scripts/config -k --disable CONFIG_GENERIC_CPU
scripts/config -k --enable CONFIG_M${MARCH^^}
