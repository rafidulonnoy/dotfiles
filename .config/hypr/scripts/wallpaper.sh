#!/bin/bash

# Directory containing pre-generated wallpaper thumbnails
THUMBNAIL_DIR="$HOME/.cache/wofi-thumbs/"

# Directory containing the original wallpapers
WALLPAPER_DIR="$HOME/wallpapers/"

# Function to generate the Wofi menu showing cached thumbnails
menu() {
    find "${THUMBNAIL_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}

# Main function to handle wallpaper selection and updates
main() {
    # Show Wofi menu and store selected entry
    choice=$(menu | wofi -c ~/.config/wofi/config1 -s ~/.config/wofi/style1.css \
        --show dmenu --prompt " Select Wallpaper:" -n)

    # Extract the selected thumbnail file path
    selected_thumbnail=$(echo "$choice" | sed 's/^thumb://')

    # Get the base filename (without the directory and extension)
    base_name=$(basename "$selected_thumbnail" | sed 's/\.[^.]*$//')

    # Find the corresponding main wallpaper file
    selected_wallpaper=$(find "$WALLPAPER_DIR" -type f -iname "$base_name.*" | head -n 1)

    # Set the wallpaper using swww with a smooth transition
    swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration 1.5

    # Generate colors using pywal
    wal -i "$selected_wallpaper" -n

    # Reload SwayNotificationCenter CSS (if you use themed notifications)
    # swaync-client --reload-css

    # Update the current Kitty theme with pywal colors
    cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf

    # Update Firefox theme (if using Pywalfox)
    # pywalfox update

    # Extract two colors from the generated `colors.sh` file for Cava visualizer
    color1=$(awk 'match($0, /color2=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
    color2=$(awk 'match($0, /color3=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)

    # Update the Cava visualizer configuration with new colors
    cava_config="$HOME/.config/cava/config"
    sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" "$cava_config"
    sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" "$cava_config"

    # Restart Cava to apply new colors
    pkill -USR2 cava || cava -p "$cava_config"

    # Save the selected wallpaper as "pywallpaper.jpg" in ~/wallpapers/
    cp -r "$selected_wallpaper" ~/wallpapers/pywallpaper.jpg
}

# Run the main function
main
