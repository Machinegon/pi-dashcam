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

UPTIME=0
while true; do
    if [ $UPTIME -gt 900 ]; then # 15 minutes file rotation
        $SCRIPT restart
    fi

    # Power is down, stop and shutdown
    IOVAL=`cat ${GPIO}/${POWERGPIO}`
    if [ IOVAL -eq 0 ]; then
        $SCRIPT stop
        break
    fi
    sleep 5
    UPTIME+=5
done


echo "Shutting down system"
# shutdown now
