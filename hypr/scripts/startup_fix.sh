#!/bin/bash
# Startup Fix (Monitor & Waybar Reset)
# Berguna untuk mengatasi masalah Waybar/Wallpaper tidak muncul setelah login karena monitor belum siap

sleep 1
hyprctl reload
killall waybar hyprpaper dunst
sleep 1
waybar &
hyprpaper &
dunst &

# Force Apply Theme (Karena kadang ke-reset)
gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
hyprctl setcursor Bibata-Modern-Ice 24
