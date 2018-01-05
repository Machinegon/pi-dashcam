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
GPIO=/sys/class/gpio/
POWERGPIO=11
PID_FILE="/tmp/dashcam.pid"

UPTIME=0
cd $GPIO
echo $POWERGPIO > export
while true; do
    if [ -f $PID_FILE ]; then
        if [ $UPTIME -gt 900 ]; then # 15 minutes file rotation
            echo "Rotating..."
            $SCRIPT restart
        fi
        UPTIME=$((UPTIME+5))

        # Power is down, stop and shutdown
        IOVAL=`cat ${GPIO}gpio${POWERGPIO}/value`
        if [ $IOVAL -eq 1 ]; then
            echo "Power is down, stopping"
            $SCRIPT stop
            shutdown now
        fi    
    else
        echo "Waiting for $SCRIPT PID ..."
    fi
    sleep 5
done