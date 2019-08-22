#!/bin/sh

DEVICE="Wacom Bamboo Craft"
STYLUS="${DEVICE} Pen stylus"
ERASER="${DEVICE} Pen eraser"
FINGER="${DEVICE} Finger touch"
PAD="${DEVICE} pad"

logger "Setting up ${DEVICE}:"
#logger "Device: {$DEVPATH}"
#logger "Action: {$ACTION}"

# Check if wacom exists/installed, skip if not
XSETWACOM_BIN=$(command -v xsetwacom)
if [ -z "${XSETWACOM_BIN}" ]; then
    exit 0
fi

NUM_DEVICES=$(xsetwacom --list devices | wc -l)
if [ "${NUM_DEVICES}" = "0" ]; then
    exit 0
fi

# Configuration for Wacom Bamboo CTH-461 on Ubuntu 18.04
#
# Add this script to your '~/.bashrc'
# (based on http://burner.com/autodesk-stuff/remapping-wacom-buttons-linux/)

#  $ xsetwacom list dev
# Wacom Bamboo Craft Pen stylus         id: 11  type: STYLUS
# Wacom Bamboo Craft Finger touch 	id: 12	type: TOUCH
# Wacom Bamboo Craft Pad pad      	id: 13	type: PAD
# Wacom Bamboo Craft Pen eraser   	id: 17	type: ERASER

#  Wacom Graphire4 4x5 stylus      	id: 12	type: STYLUS
#  Wacom Graphire4 4x5 eraser      	id: 13	type: ERASER
#  Wacom Graphire4 4x5 cursor      	id: 14	type: CURSOR
#  Wacom Graphire4 4x5 pad         	id: 15	type: PAD


# libwacom-list-local-devices

# $ xsetwacom -s --get "${STYLUS}" all
# xsetwacom set "${STYLUS}" "Area" "0 0 14720 9200"
# xsetwacom set "${STYLUS}" "BindToSerial" "0"
# xsetwacom set "${STYLUS}" "Button" "1" "button +1 "
# xsetwacom set "${STYLUS}" "Button" "2" "button +2 "
# xsetwacom set "${STYLUS}" "Button" "3" "button +3 "
# xsetwacom set "${STYLUS}" "Button" "8" "button +8 "
# xsetwacom set "${STYLUS}" "Gesture" "off"
# xsetwacom set "${STYLUS}" "Mode" "Absolute"
# xsetwacom set "${STYLUS}" "PanScrollThreshold" "1300"
# xsetwacom set "${STYLUS}" "PressureCurve" "0 0 100 100"
# xsetwacom set "${STYLUS}" "PressureRecalibration" "on"
# xsetwacom set "${STYLUS}" "RawSample" "4"
# xsetwacom set "${STYLUS}" "Rotate" "none"
# xsetwacom set "${STYLUS}" "ScrollDistance" "0"
# xsetwacom set "${STYLUS}" "Suppress" "2"
# xsetwacom set "${STYLUS}" "TabletDebugLevel" "0"
# xsetwacom set "${STYLUS}" "TabletPCButton" "off"
# xsetwacom set "${STYLUS}" "TapTime" "250"
# xsetwacom set "${STYLUS}" "Threshold" "26"
# xsetwacom set "${STYLUS}" "ToolDebugLevel" "0"
# xsetwacom set "${STYLUS}" "Touch" "off"
# xsetwacom set "${STYLUS}" "ZoomDistance" "0"

logger "Configuring: ${STYLUS}"

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

# $ /usr/bin/xsetwacom -s --get "Wacom Bamboo Craft Finger touch" all
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Area" "0 0 15360 10240"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Button" "1" "button +0 "
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Button" "2" "button +0 "
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Button" "3" "button +0 "
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Button" "8" "button +8 "
# xsetwacom set "Wacom Bamboo Craft Finger touch" "ToolDebugLevel" "0"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "TabletDebugLevel" "0"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Suppress" "2"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "RawSample" "4"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "PressureCurve" "0 0 100 100"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Mode" "Absolute"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Touch" "on"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Gesture" "on"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "ZoomDistance" "675"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "ScrollDistance" "18"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "TapTime" "220"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Rotate" "none"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "Threshold" "0"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "BindToSerial" "0"
# xsetwacom set "Wacom Bamboo Craft Finger touch" "PanScrollThreshold" "1300"

logger "Configuring: Wacom Bamboo Craft Finger touch"
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" ScrollDistance 18
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" TapTime 220

/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Button" "1" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Button" "2" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Button" "3" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Button" "8" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Gesture" "off"
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Touch" "off"


# $ /usr/bin/xsetwacom -s --get "Wacom Bamboo Craft Pad pad" all
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Button" "1" "button +1 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Button" "2" "button +2 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Button" "3" "button +3 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Button" "8" "button +8 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Button" "9" "button +9 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "ToolDebugLevel" "0"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "TabletDebugLevel" "0"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Suppress" "2"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "RawSample" "4"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Mode" "Absolute"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Touch" "off"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Gesture" "off"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "ZoomDistance" "0"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "ScrollDistance" "0"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "TapTime" "250"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "RelWheelUp" "1" "button +5 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "RelWheelDown" "2" "button +4 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "AbsWheelUp" "3" "button +4 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "AbsWheelDown" "4" "button +5 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "AbsWheel2Up" "5" "button +4 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "AbsWheel2Down" "6" "button +5 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "StripLeftUp" "1" "button +4 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "StripLeftDown" "2" "button +5 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "StripRightUp" "3" "button +4 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "StripRightDown" "4" "button +5 "
# xsetwacom set "Wacom Bamboo Craft Pad pad" "Threshold" "0"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "BindToSerial" "0"
# xsetwacom set "Wacom Bamboo Craft Pad pad" "PanScrollThreshold" "1300"

logger "Configuring: Wacom Bamboo Craft Pad pad"
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "1" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "2" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "3" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "8" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "9" 0


# $ /usr/bin/xsetwacom -s --get "Wacom Bamboo Craft Pen eraser" all
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Area" "0 0 14720 9200"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Button" "1" "button +1 "
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Button" "2" "button +2 "
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Button" "3" "button +3 "
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Button" "8" "button +8 "
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "ToolDebugLevel" "0"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "TabletDebugLevel" "0"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Suppress" "2"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "RawSample" "4"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "PressureCurve" "0 0 100 100"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Mode" "Absolute"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Touch" "off"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Gesture" "off"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "ZoomDistance" "0"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "ScrollDistance" "0"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "TapTime" "250"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Rotate" "none"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "Threshold" "26"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "BindToSerial" "0"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "PressureRecalibration" "on"
# xsetwacom set "Wacom Bamboo Craft Pen eraser" "PanScrollThreshold" "1300"


logger "Configuring: Wacom Bamboo Craft Pen eraser"
# /usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "Area" "0 0 0 0"
# /usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "Area" "0 0 14720 9200"

# Setup the buttons:
# 1 = left click
# 2 = middle click
# 3 = right click
# 0 = none
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "Button" "1" "0"
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "Button" "2" "0"
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "Button" "3" "0"
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "Button" "8" "0"

/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "Threshold" "80"
#/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "Suppress" 10

# /usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "PressureCurve" "0 100 0 100" # super soft
# /usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "PressureCurve" "0 0 100 100" # linear
# /usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen eraser" "PressureCurve" "100 0 100 0" # super firm

exit 0
