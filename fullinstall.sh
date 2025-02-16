#!/bin/bash
required_commands=("base-devel" "git")
for app in "${required_commands[@]}"; do
  if pacman -Qi "$app" &> /dev/null; then
    echo "[SKIPPED] $app is already installed."
  else
    echo "[INSTALLING] $app..."
    if sudo pacman -S --needed --noconfirm "$app"; then
      echo "[SUCCESS] $app installed!"
    else
      echo "[ERROR] Failed to install $app."
    fi
  fi
done
# installing paru
if command -v paru &> /dev/null; then
  echo "paru is installed. proceeding..."
else
  echo "paru not installed. Installing paru..."
  git clone https://aur.archlinux.org/paru.git ~/paru
  cd paru
  makepkg -si --noconfirm
  cd -
  rm -rf ~/paru
fi
# download all the wallpapers
if [ -d "~/wallpaper" ]; then
  echo "wallpaper directory found."
else
  git clone https://github.com/rafidulonnoy/wallpaper.git
fi
# list of packages to install
APPS=(
  "7zip"
  "bat"
  "bibata-cursor-theme-bin"
  "brightnessctl"
  "blueman"
  "bluez"
  "btop"
  "cava"
  "chafa"
  "cliphist"
  "code"
  "curl"
  "discord"
  "eza"
  "fastfetch"
  "fd"
  "fzf"
  "ghostty"
  "gvfs"
  "go"
  "hypridle"
  "hyprpicker"
  "hyprshot"
  "hyprlock"
  "htop"
  "imv"
  "inotify-tools"
  "jq"
  "kitty"
  "less"
  "libnotify"
  "libreoffice-fresh"
  "materia-gtk-theme"
  "neovim"
  "network-manager-applet"
  "nwg-look"
  "ncspot"
  "pavucontrol"
  "poppler"
  "pipewire"
  "pipewire-pulse"
  "pipewire-alsa"
  "pipewire-jack"
  "pulsemixer"
  "pywal"
  "pyprland"
  "qt6ct"
  "starship"
  "swww"
  "swaync"
  "ttf-font-awesome"
  "ttf-jetbrains-mono-nerd"
  "tldr"
  "thunar"
  "tumbler"
  "udiskie"
  "unzip"
  "vlc"
  "waybar"
  "wofi"
  "wlogout"
  "yazi"
  "zoxide"
)
# Install apps only if not already installed
for app in "${APPS[@]}"; do
  if paru -Qi "$app" &> /dev/null; then
    echo "[SKIPPED] $app is already installed."
  else
    echo "[INSTALLING] $app..."
    if paru -S --needed --noconfirm "$app"; then
      echo "[SUCCESS] $app installed!"
    else
      echo "[ERROR] Failed to install $app."
    fi
  fi
done
echo "All requested apps processed."

wal -i ~/wallpaper/Sword Black.png -n
systemctl enable bluetooth
systemctl --user enable pipewire.service pipewire-pulse.service
systemctl --user start pipewire.service pipewire-pulse.service
systemctl --user enable brightnessctl
systemctl --user start brightnessctl
sudo cp -r -f ~/dotfiles/.config/* ~/.config/
sudo cp -r -f ~/dotfiles/.zshrc ~/
sudo cp -r -f ~/dotfiles/nixwd-home ~/nixwd-home
if ! command -v nix &> /dev/null; then
  echo "[INSTALLING] NIX..."
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi
tldr -u
notify-send "Open Terminal with MOD+return" "Hello $USER,\nWelcome to your new Arch install\n-EF"
echo "Install nerd-fonts package I didn't include it in the apps because it installs around 1GB of fonts in the system."
