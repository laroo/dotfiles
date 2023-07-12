#!/usr/bin/env bash

function _trap_ctrl_c() {
    echo "** Trapped CTRL-C"
    exit -1
}
trap _trap_ctrl_c INT

IFS=$'\n\t'
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace

# https://github.com/rubienr/wacom
# sudo apt-get install xbindkeys
# xbindkeys -f wacom_xbindkeys.cfg --nodaemon

# "notify-send --expire-time=50 'test message'"

# apt-get install xdotool
# xdotool click --repeat=8 --delay 60 4  # scroll up


# Check if wacom exists/installed, skip if not
XSETWACOM_BIN=$(command -v xsetwacom)
if [ -z "${XSETWACOM_BIN}" ]; then
    exit 0
fi

NUM_DEVICES=$(xsetwacom --list devices | wc -l)
if [ "${NUM_DEVICES}" = "0" ]; then
    exit 0
fi


STYLUS=`xsetwacom --list devices | grep -i stylus | awk 'BEGIN{FS="\t*"}{ print $1 }' | awk '{$1=$1;print}'`
ERASER=`xsetwacom --list devices | grep -i eraser | awk 'BEGIN{FS="\t*"}{ print $1 }' | awk '{$1=$1;print}'`
FINGER=`xsetwacom --list devices | grep -i finger | awk 'BEGIN{FS="\t*"}{ print $1 }' | awk '{$1=$1;print}'`
PAD=`xsetwacom --list devices | grep -i pad | awk 'BEGIN{FS="\t*"}{ print $1 }' | awk '{$1=$1;print}'`

logger "Wacom:"
logger "'${STYLUS}'"
logger "'${ERASER}'"
logger "'${FINGER}'"
logger "'${PAD}'"

if [ $# -ge 1 ] && [ -n "$1" ]
then
    ACTION="${1}"
else
    ACTION="setup"
fi


case $ACTION in
  "toggle_touch")
    TOUCH_STATE=`/usr/bin/xsetwacom --get "${FINGER}" "Touch"`
    if [ $TOUCH_STATE = 'on' ]
    then
      /usr/bin/xsetwacom --set "${FINGER}" "Touch" "off"
      notify-send --expire-time=50 'Wacom: Disabling touch'
    else
      /usr/bin/xsetwacom --set "${FINGER}" "Touch" "on"
      notify-send --expire-time=50 'Wacom: Enabling touch'
    fi
    exit 0
    ;;
  "setup")
    echo "Wacom setup..."
    ;;
  *)
    echo "No action!"
    exit 1
    ;;
esac


# Configuration for Wacom Bamboo CTH-461 on Ubuntu 18.04
#
# Add this script to your '~/.bashrc'
# (based on http://burner.com/autodesk-stuff/remapping-wacom-buttons-linux/)

#  $ xsetwacom list dev
# Wacom Bamboo Craft Pen stylus         id: 11  type: STYLUS
# Wacom Bamboo Craft Finger touch 	id: 12	type: TOUCH
# Wacom Bamboo Craft Pad pad      	id: 13	type: PAD
# Wacom Bamboo Craft Pen eraser   	id: 17	type: ERASER

# Wacom Graphire4 4x5 stylus      	id: 12	type: STYLUS
# Wacom Graphire4 4x5 eraser      	id: 13	type: ERASER
# Wacom Graphire4 4x5 cursor      	id: 14	type: CURSOR
# Wacom Graphire4 4x5 pad         	id: 15	type: PAD

# Wacom Bamboo 2FG 4x5 Pen stylus 	id: 15	type: STYLUS
# Wacom Bamboo 2FG 4x5 Pen eraser 	id: 16	type: ERASER
# Wacom Bamboo 2FG 4x5 Pad pad    	id: 17	type: PAD
# Wacom Bamboo 2FG 4x5 Finger touch	id: 18	type: TOUCH

# libwacom-list-local-devices


logger "Configuring: ${STYLUS}"
# $ xsetwacom -s --get "${STYLUS}" all

# Setup the buttons:
# 1 = left click
# 2 = middle click
# 3 = right click
# 0 = none
/usr/bin/xsetwacom --set "${STYLUS}" "Button" "1" 1
/usr/bin/xsetwacom --set "${STYLUS}" "Button" "2" 3
/usr/bin/xsetwacom --set "${STYLUS}" "Button" "3" 0

# Default=26 (pressure; lower value is more sensitive, don't like it)
/usr/bin/xsetwacom --set "${STYLUS}" "Threshold" 80

# Default=off (force to touch the tablet before clicking)
# If enabled you can only do a 'right click' when the pen is on the tablet (which is a 'left click' as well); so keep it disabled!
/usr/bin/xsetwacom --set "${STYLUS}" "TabletPCButton" "off"

# Not using this
#/usr/bin/xsetwacom --set "${STYLUS}" "ScrollDistance" 1024

/usr/bin/xsetwacom --set "${STYLUS}" TapTime 220

# Default=2 (by using 10 small shaking/shifting is not registered)
/usr/bin/xsetwacom --set "${STYLUS}" "Suppress" 20  # was 10

# Default=4 (20 is very slow, long delay)
#/usr/bin/xsetwacom --set "${STYLUS}" "RawSample" 4

# /usr/bin/xsetwacom --set "${STYLUS}" "PressureCurve" "0 100 0 100" # super soft
# /usr/bin/xsetwacom --set "${STYLUS}" "PressureCurve" "0 0 100 100" # linear
# /usr/bin/xsetwacom --set "${STYLUS}" "PressureCurve" "100 0 100 0" # super firm
/usr/bin/xsetwacom --set "${STYLUS}" "PressureCurve" "0 10 90 100" # custom


logger "Configuring: ${FINGER}"
# $ /usr/bin/xsetwacom -s --get "${FINGER}" all

#/usr/bin/xsetwacom --set "${FINGER}" "Area" "0 0 153600 102400"  # Super Slow (3.2x?)
/usr/bin/xsetwacom --set "${FINGER}" "Area" "0 0 91560 61440"  # Slower (2x)
#/usr/bin/xsetwacom --set "${FINGER}" "Area" "0 0 45780 30720"  # Slow (1x)
/usr/bin/xsetwacom --set "${FINGER}" ScrollDistance 18
/usr/bin/xsetwacom --set "${FINGER}" TapTime 60

/usr/bin/xsetwacom --set "${FINGER}" "Button" "1" 0
/usr/bin/xsetwacom --set "${FINGER}" "Button" "2" 0
/usr/bin/xsetwacom --set "${FINGER}" "Button" "3" 0
/usr/bin/xsetwacom --set "${FINGER}" "Button" "8" 0
/usr/bin/xsetwacom --set "${FINGER}" "Gesture" "off"
/usr/bin/xsetwacom --set "${FINGER}" "Touch" "on"


logger "Configuring: ${PAD}"
# $ /usr/bin/xsetwacom -s --get "${PAD}" all

# /usr/bin/xsetwacom --set "${PAD}" "Button" "1" 1             # left click  (left lower bottom)
/usr/bin/xsetwacom --set "${PAD}" "Button" "1" "key lctrl lshift lalt 3"  # toggle touch  (left lower bottom)
/usr/bin/xsetwacom --set "${PAD}" "Button" "2" 0            # Unknown
/usr/bin/xsetwacom --set "${PAD}" "Button" "3" "key lctrl lshift lalt 1" # scroll up   (left upper top)
/usr/bin/xsetwacom --set "${PAD}" "Button" "8" "key lctrl lshift lalt 2" # scroll down (left middle top)
/usr/bin/xsetwacom --set "${PAD}" "Button" "9" 3            # right click (left middle bottom)
/usr/bin/xsetwacom --set "${PAD}" "Touch" "off"
/usr/bin/xsetwacom --set "${PAD}" "Mode" "Absolute" # Works like a touchpad


logger "Configuring: ${ERASER}"
# $ /usr/bin/xsetwacom -s --get "${ERASER}" all

# Setup the buttons:
# 1 = left click
# 2 = middle click
# 3 = right click
# 0 = none
/usr/bin/xsetwacom --set "${ERASER}" "Button" "1" "0"
/usr/bin/xsetwacom --set "${ERASER}" "Button" "2" "0"
/usr/bin/xsetwacom --set "${ERASER}" "Button" "3" "0"
/usr/bin/xsetwacom --set "${ERASER}" "Button" "8" "0"

/usr/bin/xsetwacom --set "${ERASER}" "Threshold" "80"


exit 0
