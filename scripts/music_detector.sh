#!/bin/bash
LOCK_FILE="$HOME/.cache/eww-music-ctrl.lock"

playerctl --follow status | while read status; do
    if [ "$status" = "Playing" ]; then
        eww open musicbar
    elif [ "$status" = "Paused" ]; then
        echo ""
    else
        eww close musicbar
        
        if [ -f "$LOCK_FILE" ]; then
            eww close music_ctrl
            rm "$LOCK_FILE"
        fi
    fi
done

