#!/bin/bash

# Define colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🌌 MythEclipse Dotfiles Installer${NC}"
echo "-------------------------------------"

# Check for yay
if ! command -v yay &> /dev/null; then
    echo -e "${RED}Error: 'yay' AUR helper is not installed.${NC}"
    echo "Please install yay first: https://github.com/Jguer/yay"
    exit 1
fi

# 1. Install Packages
echo -e "\n${YELLOW}📦 Installing packages from pkglist.txt...${NC}"
if [ -f "pkglist.txt" ]; then
    yay -S --needed - < pkglist.txt
else
    echo -e "${RED}pkglist.txt not found! Skipping package installation.${NC}"
fi

# 2. Backup & Link Configs
BACKUP_DIR="$HOME/.config/backup_$(date +%Y%m%d_%H%M%S)"
echo -e "\n${YELLOW}hk️ Backing up existing configs to $BACKUP_DIR...${NC}"
mkdir -p "$BACKUP_DIR"

# List of folders to symlink (matches your repo structure)
CONFIGS=(
    "hypr"
    "waybar"
    "kitty"
    "wofi"
    "dunst"
    "fastfetch"
    "btop"
    "wlogout"
    "thunar"
    "nwg-look"
    "nwg-displays"
    "micro"
)

# Individual files to symlink
FILES=(
    "starship.toml"
)

# Process Directories
for DIR in "${CONFIGS[@]}"; do
    TARGET="$HOME/.config/$DIR"
    SOURCE="$(pwd)/$DIR"

    if [ -d "$SOURCE" ]; then
        if [ -d "$TARGET" ] || [ -L "$TARGET" ]; then
            echo "Backing up $DIR..."
            mv "$TARGET" "$BACKUP_DIR/"
        fi
        
        echo -e "${GREEN}Linking $DIR...${NC}"
ln -s "$SOURCE" "$TARGET"
    else
        echo "Warning: Source directory $SOURCE not found."
    fi
done

# Process Files
for FILE in "${FILES[@]}"; do
    TARGET="$HOME/.config/$FILE"
    SOURCE="$(pwd)/$FILE"

    if [ -f "$SOURCE" ]; then
        if [ -f "$TARGET" ] || [ -L "$TARGET" ]; then
            echo "Backing up $FILE..."
            mv "$TARGET" "$BACKUP_DIR/"
        fi

        echo -e "${GREEN}Linking $FILE...${NC}"
ln -s "$SOURCE" "$TARGET"
    else
        echo "Warning: Source file $SOURCE not found."
    fi
done

echo -e "\n${GREEN}✅ Installation & Setup Complete!${NC}"
echo "Please restart Hyprland to apply changes."
