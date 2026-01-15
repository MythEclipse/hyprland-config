#!/bin/bash

# Define colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🌌 MythEclipse Hyprland Installer${NC}"
echo "-------------------------------------"

# --- 1. Helper Check (Yay/Paru) ---
AUR_HELPER=""
if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
else
    echo -e "${YELLOW}AUR helper (yay/paru) not found.${NC}"
    read -p "Install yay-bin now? (y/n): " INSTALL_YAY
    if [[ "$INSTALL_YAY" =~ ^[Yy]$ ]]; then
        echo "Installing yay..."
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        cd /tmp/yay-bin || exit
        makepkg -si --noconfirm
        cd - || exit
        AUR_HELPER="yay"
    else
        echo -e "${RED}Cannot proceed without an AUR helper.${NC}"
        exit 1
    fi
fi

# --- 2. Install Packages ---
echo -e "\n${YELLOW}📦 Installing packages...${NC}"
if [ -f "pkglist.txt" ]; then
    $AUR_HELPER -S --needed --noconfirm - < pkglist.txt
else
    echo -e "${RED}pkglist.txt not found! Skipping package installation.${NC}"
fi

# --- 3. Shell Setup (Zsh + Oh My Zsh) ---
echo -e "\n${YELLOW}🐚 Setting up Zsh...${NC}"
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo "Changing default shell to zsh..."
    chsh -s $(which zsh)
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Install Plugins (Autosuggestions & Syntax Highlighting)
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "Oh My Zsh is already installed."
fi

# --- 4. Backup & Link Configs ---
BACKUP_DIR="$HOME/.config/backup_$(date +%Y%m%d_%H%M%S)"
echo -e "\n${YELLOW}hk️ Backing up existing configs to $BACKUP_DIR...${NC}"
mkdir -p "$BACKUP_DIR"

# Folders to link
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

# Files to link
FILES=(
    "starship.toml"
)

# Process Directories
for DIR in "${CONFIGS[@]}"; do
    TARGET="$HOME/.config/$DIR"
    SOURCE="$(pwd)/$DIR"

    if [ -d "$SOURCE" ]; then
        if [ -d "$TARGET" ] || [ -L "$TARGET" ]; then
            mv "$TARGET" "$BACKUP_DIR/"
        fi
        ln -s "$SOURCE" "$TARGET"
        echo -e "Linked ${GREEN}$DIR${NC}"
    fi
done

# Process Files
for FILE in "${FILES[@]}"; do
    TARGET="$HOME/.config/$FILE"
    SOURCE="$(pwd)/$FILE"

    if [ -f "$SOURCE" ]; then
        if [ -f "$TARGET" ] || [ -L "$TARGET" ]; then
            mv "$TARGET" "$BACKUP_DIR/"
        fi
        ln -s "$SOURCE" "$TARGET"
        echo -e "Linked ${GREEN}$FILE${NC}"
    fi
done

# --- 5. System Services & Settings ---
echo -e "\n${YELLOW}⚙️  Configuring system settings...${NC}"

# Enable Services
sudo systemctl enable --now bluetooth.service
# NetworkManager is usually critical, careful not to restart if remote
sudo systemctl enable NetworkManager.service 

# Font Cache
echo "Refreshing font cache..."
fc-cache -f

# Apply GTK Theme (Tokyonight)
echo "Applying GTK Theme..."
gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono Nerd Font 10'

# --- 6. Wallpaper Fix ---
echo -e "\n${YELLOW}🖼️  Setting up Wallpaper...${NC}"
mkdir -p ~/Pictures/Wallpapers
# Note: You might want to copy a default wallpaper here if you had one in the repo
echo "Note: Please check ~/.config/hypr/hyprpaper.conf to ensure the wallpaper path is correct."

echo -e "\n${GREEN}✅ Installation Complete!${NC}"
echo -e "Please ${BLUE}logout${NC} and log back in (or restart) to see changes."