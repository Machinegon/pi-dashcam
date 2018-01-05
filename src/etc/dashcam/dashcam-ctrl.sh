# !/bin/sh

### 
# Name: DASHCAM-CONTROLLER
# Summary:
## This script monitors the dashcam daemon and restart it every 30 minutes.
## If the system goes to emergency power, the script stops the daemon and shuts down the system.
###


# Set stop-detection gpio
# The pi will stop recording when low and save the video
SCRIPT=/etc/init.d/pi-dashcam.sh
PID_FILE="/tmp/dashcam.pid"

UPTIME=0
while true; do
    if [ -f $PID_FILE ]; then
        if [ $UPTIME -gt 900 ]; then # 15 minutes file rotation
            echo "Rotating..."
            $SCRIPT restart
        fi
        UPTIME=$((UPTIME+5))
    else
        echo "Waiting for $SCRIPT PID ..."
    fi
    sleep 5
done