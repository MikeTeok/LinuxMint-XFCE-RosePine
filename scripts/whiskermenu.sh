#!/bin/bash
xdotool getmouselocation | awk -F '[: ]+' '{print $2, $4}' | xargs -I {} sh -c 'xdotool mousemove 745 520 ; xfce4-popup-whiskermenu -p ; xdotool mousemove {}'
