#!/bin/bash
# Function to delete matching files/dirs in $HOME/.config
delete_matching_configs() {
  DOTFILES_DIR="$HOME/dotfiles/.config"
  TARGET_DIR="$HOME/.config"
  TRASH_DIR="$HOME/.local/share/Trash/files"
  # Safety checks
  if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "Error: Dotfiles directory $DOTFILES_DIR not found!"
    return 1  # Return with error code instead of exiting
  fi

  if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Target directory $TARGET_DIR not found!"
    return 1  # Return with error code instead of exiting
  fi
  # If trash dir doesn't exist then it will create it
  if [[ ! -d "$TRASH_DIR" ]]; then
    mkdir -p "$TRASH_DIR"
  fi

  # Get list of entries
  mapfile -t entries < <(find "$DOTFILES_DIR" -maxdepth 1 -mindepth 1 -exec basename {} \; 2>/dev/null)

    # Show what will be deleted
    echo "=== Files/Dirs to potentially delete ==="
    for entry in "${entries[@]}"; do
      target_entry="$TARGET_DIR/$entry"
      if [[ -e "$target_entry" ]]; then
        echo " - $target_entry"
      fi
    done
    # Ask if user wants to back up files/folders
    read -p "Do you want to back up these files/folders to trash? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "Backing up to trash..."
      for entry in "${entries[@]}"; do
        target_entry="$TARGET_DIR/$entry"
        if [[ -e "$target_entry" ]]; then
          mv "$target_entry" "$TRASH_DIR/"
          echo "Backed up: $target_entry"
        fi
      done
      echo "Backup completed."
    fi
    # Confirm destruction
    read -p "DANGER! This will PERMANENTLY delete matching files/dirs in $TARGET_DIR. Continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "Aborted."
      return 0  # Return without error
    fi

    # Delete operations
    for entry in "${entries[@]}"; do
      dotfile_entry="$DOTFILES_DIR/$entry"
      target_entry="$TARGET_DIR/$entry"

        # Handle directories
        if [[ -d "$dotfile_entry" ]] && [[ -d "$target_entry" ]]; then
          echo "Deleting directory: $target_entry"
          rm -rf -- "$target_entry"

        # Handle files
      elif [[ -f "$dotfile_entry" ]] && [[ -f "$target_entry" ]]; then
        echo "Deleting file: $target_entry"
        rm -f -- "$target_entry"
        fi
      done

      echo "Config cleanup completed."
    }
    cd
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
      echo "[SKIPPED] Paru is installed. proceeding..."
    else
      echo "[INSTALLING] Paru not installed. Installing paru..."
      git clone https://aur.archlinux.org/paru.git ~/paru
      cd ~/paru
      makepkg -si --noconfirm
      cd -
      rm -rf ~/paru
    fi
    # download all the wallpapers
    wallpaper_dir="$HOME/wallpaper"
    if [ -d "$wallpaper_dir" ]; then
      echo "[SKIPPED] Wallpaper directory found."
    else
      git clone https://github.com/rafidulonnoy/wallpaper.git ~/wallpaper
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
      "ffmpeg"
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
      "noto-fonts"
      "noto-fonts-cjk"
      "noto-fonts-emoji"
      "noto-fonts-extra"
      "nwg-look"
      "ncspot"
      "obsidian"
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
      "stow"
      "swww"
      "swaync"
      "ttf-font-awesome"
      "ttf-jetbrains-mono-nerd"
      "ttf-dejavu"
      "tldr"
      "thunar"
      "tumbler"
      "tree"
      "udiskie"
      "unzip"
      "vlc"
      "waybar"
      "wofi"
      "wlogout"
      "yazi"
      "zoxide"
      "zsh"
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
    echo "[SUCCESS] All requested apps processed."

# check if swww is running
if command -v swww &> /dev/null; then
  swww img ~/wallpaper/assassin\'sCreed.png
fi
# check if pywal is running
if pgrep "wal" &> /dev/null; then
  echo '[SKIPPED] pywal is running'
else
  wal -i ~/wallpaper/assassin\'sCreed.png -n
fi
# Manages dotfiles
read -p "Do you want to add the config files? (y/n): " -n 1 -r
echo  # Add a newline after single-character input
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if command -v stow &> /dev/null; then
    read -p "Do you want to add the config files using stow? (y/n): " -n 1 -r
    echo  # Add a newline after single-character input
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      cd ~/.config
      delete_matching_configs
      cd ~/dotfiles
      stow .
      cd -
      echo '[SUCCESS] Added config files successfully'
    else
      cd ~/.config
      delete_matching_configs
      sudo cp -r -f ~/dotfiles/.config/* ~/.config/
      sudo cp -r -f ~/dotfiles/.zshrc ~/
      sudo cp -r -f ~/dotfiles/nixwd-home ~/
      cd -
      echo '[SUCCESS] Added config files successfully'
    fi
  fi
fi
if (command -v zsh && echo $SHELL != /usr/bin/zsh) &> /dev/null; then
  read -p "Do you want to change your shell to zsh? (y/n): " -n 1 -r
  echo  # Add a newline after single-character input
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Enter your username: "
    chsh -s /usr/bin/zsh $REPLY
    echo '[SUCCESS] Your shell was changed into zsh'
  else
    echo 'Your shell is '$SHELL
  fi
fi
# INSTALLING nix
if command -v nix &> /dev/null; then
  echo '[SKIPPED] Nix installed'
else
  read -p "Do you want to install nix? (y/n): " -n 1 -r
  echo  # Add a newline after single-character input
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "[INSTALLING] NIX..."
    sh <(curl -L https://nixos.org/nix/install) --daemon
    echo '[SUCCESS] Nix was installed'
    # source ~/.zshrc
    # cd ~/nixwd-home/
    # nix run home-manager -- init --switch .
    # cd -
    echo '[WARNING] Now cd into nixwd-home and run nix run home-manager -- init --switch . for installing nix programs' 
  fi
fi
if command -v yazi &> /dev/null; then
  if [ ! -d ~/.config/yazi/flavors/catppuccin-frappe.yazi ]; then
    ya pack -a yazi-rs/flavors:catppuccin-frappe
    echo '[SUCCESS] Yazi theme catppuccin-frappe installed'
  else
    echo 'yazi theme catppuccin-frappe found'
  fi
  if [ ! -d ~/.config/yazi/plugins/mount.yazi ]; then
    ya pack -a yazi-rs/plugins:mount
    echo '[SUCCESS] Yazi plugin mount installed'
  else
    echo 'yazi plugin mount found'
  fi
fi
if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  echo "[SKIPPED] NVM installed..."
else
  # Install NVM
  NVM_DIR="$HOME/.nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  echo "[SUCCESS] NVM installed. Reload your shell and run: nvm install node"
fi
# Download zinit, if it's not there yet
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
if pgrep 'bluetooth' &> /dev/null; then
  echo 'bluetooth enabled'
else
  systemctl enable bluetooth
  systemctl start bluetooth
fi
if pgrep 'pipewire' &> /dev/null; then
  echo 'pipewire enabled'
else
  systemctl --user enable pipewire.service pipewire-pulse.service
  systemctl --user start pipewire.service pipewire-pulse.service
fi
if pgrep 'brightnessctl' &> /dev/null; then
  echo 'brightnessctl enabled'
else
  systemctl --user enable brightnessctl
  systemctl --user start brightnessctl
fi
chmod +x ~/.config/hypr/scripts/*
notify-send "Open Terminal with MOD+return" "Hello $USER,\nWelcome to your new Arch install\n"
hyprctl reload
echo "[WARNING] Install nerd-fonts package I didn't include it in the apps because it installs around 1GB of fonts in the system."
echo '[WARNING] Now cd into nixwd-home and run nix run home-manager -- init --switch . for installing nix programs.' 
