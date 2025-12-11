#!/bin/bash

# Get current workspace number
current_ws=$(wmctrl -d | grep '*' | cut -d' ' -f1)

# Target workspace (you can pass this as argument or toggle)
target_ws=$(( (current_ws + 1) % 4 ))

# Take screenshot of current workspace
import -window root ~/ws_current.png

# Switch to target workspace
wmctrl -s $target_ws

# Small delay to let the switch happen
sleep 0.1

# Take screenshot of new workspace
import -window root ~/ws_target.png

# Use ffmpeg or mpv to animate the transition (e.g., horizontal slide)
ffmpeg -y -loop 1 -t 1 -i ~/ws_current.png \
       -loop 1 -t 1 -i ~/ws_target.png \
       -filter_complex "[0][1]xfade=transition=slideleft:duration=0.5:offset=0" \
       -c:v libx264 -pix_fmt yuv420p ~/ws_transition.mp4

# Play the animation fullscreen
mpv --fs --no-border --ontop --loop=inf ~/ws_transition.mp4 &

# Wait until animation ends
sleep 0.5

# Kill the video player (or let it quit after duration)
pkill mpv

