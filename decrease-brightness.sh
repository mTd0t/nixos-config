#!/usr/bin/env bash
# brightness-down.sh – step VGA-1 brightness down by 0.1 each run
# NixOS-safe: no hard-coded paths, uses whatever xrandr is in $PATH

OUTPUT="VGA-1"
STEP="0.1"
MIN="0.1"

# Get current brightness
CUR=$(xrandr --verbose | awk "/^$OUTPUT connected/,/Brightness:/" | awk -F': ' '/Brightness:/ {print $2}')
[[ -z "$CUR" ]] && { echo "Could not read brightness for $OUTPUT"; exit 1; }

# Calculate new brightness
NEW=$(awk -v c="$CUR" -v s="$STEP" -v m="$MIN" 'BEGIN { printf "%.2f", (c-s<m?m:c-s) }')

# Apply
xrandr --output "$OUTPUT" --brightness "$NEW"
