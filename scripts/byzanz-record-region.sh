#!/bin/bash

# AUTHOR:   (c) Rob W 2012, modified by MHC (http://askubuntu.com/users/81372/mhc)
# NAME:     GIFRecord 0.1
# DESCRIPTION:  A script to record GIF screencasts.
# LICENSE:  GNU GPL v3 (http://www.gnu.org/licenses/gpl.html)
# DEPENDENCIES:   byzanz,gdialog,notify-send (install via sudo add-apt-repository ppa:fossfreedom/byzanz; sudo apt-get update && sudo apt-get install byzanz gdialog notify-osd)

TIME=$(date +"%Y-%m-%d_%H%M%S")
DELAY=5
DEFDUR=10
FOLDER="$HOME/Pictures"

function _trap_exit () {
    echo "[exit]"
}
trap _trap_exit EXIT

function _trap_ctrl_c() {
    echo "** Trapped CTRL-C"
    exit -1
}
trap _trap_ctrl_c INT

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

# Sound notification to let one know when recording is about to start (and ends)
beep() {
    paplay /usr/share/sounds/freedesktop/stereo/camera-shutter.oga &
}

# Custom recording duration as set by user
USERDUR=$(gdialog --title "Duration?" --inputbox "Please enter the screencast duration in seconds" 200 100 2>&1)

# Duration and output file
if [ $USERDUR -gt 0 ]; then
    D=$USERDUR
else
    D=$DEFDUR
fi

#XWININFO=$(xwininfo)
#echo $XWININFO

# xrectsel from https://github.com/lolilolicon/xrectsel
RECORDING_AREA=$(xrectsel "--x=%x --y=%y --width=%w --height=%h") || exit -1

notify-send "GIFRecorder" "Recording duration set to ${D} seconds. Recording will start in ${DELAY} seconds."
for (( i=$DELAY; i>0; --i )) ; do
    echo $i
    sleep 1
done
beep
#byzanz-record --verbose --delay=0 ${ARGUMENTS} $D
byzanz-record -c --verbose --delay=0 --duration=$D $RECORDING_AREA "$FOLDER/GIFrecord_$TIME.gif"
beep

# Notify the user of end of recording.
notify-send "GIFRecorder" "Screencast saved to ${FOLDER}/GIFrecord_$TIME.gif"

