#!/usr/bin/env bash

polybar-msg cmd quit

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	echo "---" | tee -a /tmp/polybar-$m.log
	MONITOR=$m polybar main -c ~/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar-$m.log > /dev/null & disown
done

echo "Bars launched..."
