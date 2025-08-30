#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash xorg.xrandr

# Get the current brightness level for VGA-0
current_brightness=$(xrandr --verbose --current | grep -A5 "VGA-1" | grep Brightness | awk '{print $2}')

# Check if current_brightness is empty
if [ -z "$current_brightness" ]; then
    echo "Error: Could not retrieve current brightness for VGA-0"
    exit 1
fi

# Calculate new brightness (increase by 0.1)
new_brightness=$(echo "$current_brightness + 0.1" | bc)

# Apply new brightness level
xrandr --output VGA-1 --brightness $new_brightness

echo "Brightness increased to $new_brightness"
