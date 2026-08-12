#!/usr/bin/env bash

# Automatically detect the first battery in sysfs
BAT=$(ls -1 /sys/class/power_supply/ 2>/dev/null | grep -E '^BAT' | head -n 1)

# If no battery exists (e.g., Desktop PC), exit cleanly without outputting anything
if [ -z "$BAT" ]; then
    exit 0
fi

# Fetch battery percentage and state
CAPACITY=$(cat /sys/class/power_supply/"$BAT"/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/"$BAT"/status 2>/dev/null)

if [ "$STATUS" = "Charging" ];then 
    filter="%{F#ffff00}C" ; 
elif [ "$CAPACITY" -lt 20 ]; then 
     filter="%{F#ff1111}";
else 
    filter="%{F#00ff00}";
fi

# Print output for Polybar
echo " ${filter}${CAPACITY}%%{F-}"

