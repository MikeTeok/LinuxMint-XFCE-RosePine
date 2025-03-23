#!/bin/bash

playerctl --follow status | while read status; do
    if [ "$status" = "Playing" ]; then
        eww open musicbar
    elif [ "$status" = "Paused" ]; then
        echo ""
    else
        eww close musicbar
    fi
done

