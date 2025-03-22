#!/bin/bash

LOCK_FILE="$HOME/.cache/eww-volume-popup.lock"
TIME_FILE="$HOME/.cache/eww-volume-time"
VOLUME_FILE="$HOME/.cache/eww-volume-prev"  # Store prev_volume here

# Initialize prev_volume file if not exist
# Get the current volume at startup
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ {print $5}' | tr -d '%')

# Initialize prev_volume with the current volume
echo "$current_volume" > "$VOLUME_FILE"

volume_changed() {
    eww open volume_popup

    while true; do
        sleep_time=$(( 3 - ($(date +%s) - $(cat "$TIME_FILE")) ))  # Get latest prev_time from file
        echo "before sleep time $(cat "$TIME_FILE")"

        if (( sleep_time > 0 )); then
            sleep "$sleep_time"
        fi

        echo "after sleep time $(cat "$TIME_FILE")"

        if (( $(date +%s) - $(cat "$TIME_FILE") >= 3 )); then
            rm -f "$LOCK_FILE"
            pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ {print $5}' | tr -d '%' > "$VOLUME_FILE"  # ✅ Update prev_volume in file
            eww close volume_popup
            break
        fi
    done &
}

while read -r line; do
    current_time=$(date +%s)
    current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume:/ {print $5}' | tr -d '%')

    prev_volume=$(cat "$VOLUME_FILE")  # Read from file

    if (( current_time - $(cat "$TIME_FILE" 2>/dev/null || echo 0) > 1 )); then 
        echo "$current_time" > "$TIME_FILE"  # Update time in file
        echo "volume changed"

        if [[ ! -f "$LOCK_FILE" && "$current_volume" != "$prev_volume" ]]; then
            echo "$current_volume"
            echo "$prev_volume"
            touch "$LOCK_FILE"
            volume_changed
        fi
    fi
done < <(pactl subscribe | grep --line-buffered "Event 'change' on sink")

