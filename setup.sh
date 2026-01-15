#!/bin/bash

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Initializing MythEclipse Dotfiles Setup...${NC}"

# 1. Install Git & Base-Devel (Arch Specific)
echo -e "${GREEN}📦 Installing Git & Base-Devel...${NC}"
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Error: This script is intended for Arch Linux (pacman not found).${NC}"
    exit 1
fi

sudo pacman -Sy --noconfirm git base-devel

# 2. Clone Repository
REPO_URL="https://github.com/MythEclipse/hyprland-config.git"
DEST_DIR="$HOME/.dotfiles"

if [ -d "$DEST_DIR" ]; then
    echo -e "${GREEN}📂 Repository already exists at $DEST_DIR. Pulling latest...${NC}"
    cd "$DEST_DIR" && git pull
else
    echo -e "${GREEN}📂 Cloning repository to $DEST_DIR...${NC}"
    git clone "$REPO_URL" "$DEST_DIR"
fi

# 3. Handover to Installer
echo -e "${GREEN}▶️  Running Main Installer...${NC}"
cd "$DEST_DIR"
chmod +x install.sh
./install.sh
