<div align="center">

# 🌌 MythEclipse Dotfiles
### Personal Hyprland Configuration

![Hyprland](https://img.shields.io/badge/Hyprland-Config-00b4d8?style=for-the-badge&logo=archlinux&logoColor=white)
![Style](https://img.shields.io/badge/Style-Futuristic-7209b7?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-4361ee?style=for-the-badge)

</div>

## 🖼️ Preview
> *[Insert your screenshots here]*
>
> *Pro Tip: Add screenshots of your desktop to `assets/` folder and link them here to make your repo stand out!*

## 🛠️ The Stack

My personalized configuration for a high-performance, keyboard-driven workflow on Linux.

| Component | Tool | Description |
|-----------|------|-------------|
| **Window Manager** | [Hyprland](https://hyprland.org/) | The dynamic tiling Wayland compositor |
| **Status Bar** | [Waybar](https://github.com/Alexays/Waybar) | Highly customizable Wayland bar |
| **Terminal** | [Kitty](https://sw.kovidgoyal.net/kitty/) | GPU accelerated terminal emulator |
| **Launcher** | [Wofi](https://hg.sr.ht/~scoopta/wofi) | Application launcher / Menu |
| **Notifications** | [Dunst](https://dunst-project.org/) | Lightweight notification daemon |
| **Shell Prompt** | [Starship](https://starship.rs/) | Cross-shell prompt |
| **System Monitor** | [Btop](https://github.com/aristocratos/btop) | Resource monitor that shows usage and stats |
| **Logout** | [Wlogout](https://github.com/ArtsyMacaw/wlogout) | Wayland based logout menu |
| **Fetch** | [Fastfetch](https://github.com/fastfetch-cli/fastfetch) | Like neofetch, but faster |

## 📂 Structure

```sh
.config/
├── hypr/          # Hyprland main config
├── waybar/        # Status bar styling
├── kitty/         # Terminal colors & fonts
├── wofi/          # Launcher styling
├── dunst/         # Notification appearance
├── starship.toml  # Shell prompt config
└── ...
```

## 🚀 Installation

### Automated Setup (Recommended)
This repo includes a script to automate installing packages (Arch/Yay) and symlinking configs safely.

1. **Clone the repository:**
   ```bash
   git clone git@github.com:MythEclipse/hyprland-config.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Run the installer:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   *The script will automatically backup your existing configs to `~/.config/backup_<date>` before linking.*

### Manual Installation
If you prefer to copy files manually:

1. **Clone:**
   ```bash
   git clone git@github.com:MythEclipse/hyprland-config.git ~/.config/hypr-backup
   ```

2. **Copy Configs:**
   ```bash
   # Backup your existing configs first!
   cp -r ~/.config/hypr-backup/hypr ~/.config/
   cp -r ~/.config/hypr-backup/waybar ~/.config/
   # ... repeat for other folders
   ```

3. **Install Dependencies:**
   Install the packages listed in `pkglist.txt`:
   ```bash
   yay -S --needed - < pkglist.txt
   ```

## ⌨️ Keybindings (Highlights)
| Key | Action |
|-----|--------|
| `SUPER + Q` | Open Terminal (Kitty) |
| `SUPER + C` | Kill Active Window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + E` | File Manager |
| `SUPER + V` | Toggle Floating |
| `SUPER + R` | Application Launcher (Wofi) |

---
<div align="center">
Made with ❤️ by <a href="https://github.com/MythEclipse">MythEclipse</a>
</div>
