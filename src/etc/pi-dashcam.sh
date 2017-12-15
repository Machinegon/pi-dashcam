#! /bin/sh
# /etc/init.d/pi-dashcam.sh
### BEGIN INIT INFO
# Provides: Raspberry pi 2/3/zero-w auto dashcam daemon
# Required-Start:       $local_fs $syslog $raspivid
# Required-Stop:        $local_fs $syslog
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    Start automatic camera recording and file transfer to targeted deposit.
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin

# Set recording path and recording command here
RPATH=/home/pi/recordings
DAEMON=/usr/bin/raspivid
CTRL=/etc/dashcam/dashcam-ctrl.sh
CMD="-w 1280 -h 720 -fps 15 -b 750000 -t 0 -o $RPATH/video.h264"

# Target deposit
REMOTE_IP=192.168.0.101
REMOTE_LOGIN=pizero
REMOTE_PASS=*****
REMOTE_PATH=PICAM

. /lib/lsb/init-functions

# Start the recording daemon
start()
{
    upload()
    log_daemon_msg "Starting $DAEMON with ARGS $CMD" && log_end_msg 0
    logger -p local0.notice -t DASHCAM "$DAEMON started with args $CMD"
    start-stop-daemon --start --user pi --background --exec $DAEMON -- $CMD
    start-stop-daemon --start --user root --background --exec $CTRL
}

# Stop the recording daemon
stop()
{
    log_daemon_msg "Stopping $DAEMON and saving file" && log_end_msg 0
    start-stop-daemon --stop --exec $DAEMON
    start-stop-daemon --stop --exec $CTRL

    DATE=`date '+%Y-%m-%d_%H_%M_%S'`
    FN="${DATE}_record.h264"
    mv "$RPATH/video.h264" "$RPATH/$FN"
}

# Upload all files in RPATH to target deposit by SFTP
upload()
{
    if [ ping -c1 -w1 $REMOTE_IP ] then
        cd $RPATH
        for i in $( ls ); do
            smbclient -t 30 -U pizero%$REMOTE_PASS //$REMOTE_IP --directory $REMOTE_PATH -c 'put "$i"'
            log_daemon_msg "File $i uploaded to target deposit" && log_end_msg 0
        done
    else
        log_daemon_msg "$REMOTE_IP is unreachable, upload files skipped" && log_end_msg 0
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage:  {start|stop|restart}"
        exit 1
        ;;
esac
exit $?