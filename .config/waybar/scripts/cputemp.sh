#!/bin/bash
temp=$(sensors coretemp-isa-0000 2>/dev/null | awk '/Package id 0/ {gsub(/[^0-9.]/, "", $4); print int($4)}')
echo "TEMP ${temp}°C"
