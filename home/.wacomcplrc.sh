#!/bin/sh

# Check if wacom exists/installed, skip if not
if [ ! -f "$file" ]; then
    exit 0
fi

# Configuration for Wacom Bamboo CTH-461 on Ubuntu 18.04
#
# Add this script to your '~/.bashrc'
# (based on http://burner.com/autodesk-stuff/remapping-wacom-buttons-linux/)

#  $ xsetwacom list dev
# Wacom Bamboo Craft Pen stylus   	id: 11	type: STYLUS    
# Wacom Bamboo Craft Finger touch 	id: 12	type: TOUCH     
# Wacom Bamboo Craft Pad pad      	id: 13	type: PAD       
# Wacom Bamboo Craft Pen eraser   	id: 17	type: ERASER

#  Wacom Graphire4 4x5 stylus      	id: 12	type: STYLUS    
#  Wacom Graphire4 4x5 eraser      	id: 13	type: ERASER    
#  Wacom Graphire4 4x5 cursor      	id: 14	type: CURSOR    
#  Wacom Graphire4 4x5 pad         	id: 15	type: PAD 

# libwacom-list-local-devices

# $ xsetwacom -s --get "Wacom Bamboo Craft Pen stylus" all
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Area" "0 0 14720 9200"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "BindToSerial" "0"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Button" "1" "button +1 "
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Button" "2" "button +2 "
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Button" "3" "button +3 "
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Button" "8" "button +8 "
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Gesture" "off"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Mode" "Absolute"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "PanScrollThreshold" "1300"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "PressureCurve" "0 0 100 100"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "PressureRecalibration" "on"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "RawSample" "4"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Rotate" "none"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "ScrollDistance" "0"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Suppress" "2"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "TabletDebugLevel" "0"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "TabletPCButton" "off"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "TapTime" "250"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Threshold" "26"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "ToolDebugLevel" "0"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "Touch" "off"
# xsetwacom set "Wacom Bamboo Craft Pen stylus" "ZoomDistance" "0"

echo "Configuring: Wacom Bamboo Craft Pen stylus"

# Setup the buttons:
# 1 = left click
# 2 = right click
# 3 = none
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "Button" "1" 1
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "Button" "2" 3
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "Button" "3" 0

# Default=26 (lower value is more sensitive, don't like it)
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "Threshold" 80

# Not using this
#/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "ScrollDistance" 1024

# Default=2 (by using 10 small shaking/shifting is not registered)
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "Suppress" 10

# Default=4 (20 is very slow, long delay)
#/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "RawSample" 4

# /usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "PressureCurve" "0 100 0 100" # super soft
# /usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "PressureCurve" "0 0 100 100" # linear
# /usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "PressureCurve" "100 0 100 0" # super firm
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pen stylus" "PressureCurve" "0 10 90 100" # custom

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

echo "Configuring: Wacom Bamboo Craft Finger touch"
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" ScrollDistance 18
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" TapTime 220

/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Button" "1" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Button" "2" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Button" "3" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Finger touch" "Button" "8" 0

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

echo "Configuring: Wacom Bamboo Craft Pad pad"
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "1" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "2" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "3" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "8" 0
/usr/bin/xsetwacom --set "Wacom Bamboo Craft Pad pad" "Button" "9" 0
