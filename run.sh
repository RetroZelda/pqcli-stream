#!/bin/bash

echo "[1/5] Creating venv"
python3 -m venv ./pq-venv 

echo "[2/5] Starting venv"
source ./pq-venv/bin/activate 

# Install fake monitor
echo "[3/5] Installing fake monitor"
Xvfb :1 -screen 0 1280x720x16 &
sleep 1

# Start pqcli
echo "[4/5] Starting pqcli in uxterm"
DISPLAY=:1 uxterm -xrm "*renderFont: false" -bg $BG_COLOR -fg $FG_COLOR -hold -geometry 212x55+0+0 -e bash -c "TERM=xterm-256color pqcli --load-save $SAVE_TO_LOAD" &
sleep 1

# Start the stream
echo "[5/5] Streaming"
./stream.sh