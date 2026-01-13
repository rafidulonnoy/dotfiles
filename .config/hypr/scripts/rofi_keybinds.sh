#!/bin/bash

# Path to your Hyprland keybindings
HYPR_CONF="$HOME/.config/hypr/keybindings.conf"

# Check if file exists
if [[ ! -f "$HYPR_CONF" ]]; then
    notify-send "Error" "Keybindings file not found at $HYPR_CONF"
    exit 1
fi

# 1. Extract binds, 2. Clean whitespace, 3. Format for Rofi
# We use a more flexible regex to catch bind, binde, bindm, etc.
BINDINGS=$(grep -E '^bind[a-z]*\s*=' "$HYPR_CONF" | \
    sed -E 's/^bind[a-z]*\s*=\s*//' | \
    awk -F ',' '{
        # Trim leading/trailing whitespace from fields
        for (i=1; i<=NF; i++) {
            gsub(/^[ \t]+|[ \t]+$/, "", $i)
        }
        
        # Identify the comment/description if it exists
        desc = "No description"
        cmd = ""
        
        # The last field usually contains the comment after a #
        if ($NF ~ /#/) {
            split($NF, parts, "#")
            desc = parts[2]
            # Add the first part of the last field back to the command
            $NF = parts[1]
        }

        # Reconstruct the command (everything after mod and key)
        for(i=3; i<=NF; i++) {
            cmd = cmd $i (i==NF ? "" : ",")
        }

        # Format for Rofi: <b>Mod + Key</b> <i>Description</i> <span color='gray'>cmd</span>
        printf "<b>%-15s + %-10s</b> <i>%-25s</i> <span color=\"gray\">(%s)</span>\n", $1, $2, desc, cmd
    }')

# Show Rofi menu
CHOICE=$(echo "$BINDINGS" | rofi -dmenu -i -markup-rows -p "Hyprland Keybinds:" \
  -theme-str 'window { width: 50%; }' \
  -theme-str 'listview { lines: 15; }')

# Exit if nothing selected
[[ -z "$CHOICE" ]] && exit 0

# Extract the command from between the gray spans
# This regex looks for the content inside the parentheses in the gray span
CMD=$(echo "$CHOICE" | sed -n 's/.*<span color="gray">(\(.*\))<\/span>.*/\1/p')

# Execute
if [[ $CMD == exec* ]]; then
    # Removes 'exec ' or 'exec, ' and runs via shell
    CLEAN_CMD=$(echo "$CMD" | sed -E 's/^exec,?\s*//')
    eval "$CLEAN_CMD &"
else
    # Runs via hyprctl
    hyprctl dispatch "$CMD"
fi
