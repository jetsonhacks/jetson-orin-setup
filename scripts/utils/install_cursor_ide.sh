#!/bin/bash

set -e

# Define installation paths
INSTALL_DIR="/opt/cursor"
APPIMAGE_PATH="$INSTALL_DIR/cursor.AppImage"
ICON_PATH="$INSTALL_DIR/logo.png"
DESKTOP_ENTRY_PATH="/usr/share/applications/cursor.desktop"

# Update package lists and install FUSE for AppImage support
echo "Updating package list and installing dependencies..."
sudo apt-get update
sudo apt-get install -y libfuse2

# Create installation directory
echo "Creating installation directory..."
sudo mkdir -p "$INSTALL_DIR"

# Download the Cursor IDE AppImage for ARM64
echo "Downloading Cursor IDE AppImage..."
sudo wget -O "$APPIMAGE_PATH" "https://downloads.cursor.com/production/96e5b01ca25f8fbd4c4c10bc69b15f6228c80771/linux/arm64/Cursor-0.50.5-aarch64.AppImage"

# Make the AppImage executable
echo "Making AppImage executable..."
sudo chmod +x "$APPIMAGE_PATH"

# Download Cursor logo as 'logo.png'
echo "Downloading Cursor logo as logo.png..."
sudo wget -O "$ICON_PATH" "https://avatars.githubusercontent.com/u/126759922?s=48&v=4"

# Create a desktop entry
echo "Creating desktop launcher..."
sudo bash -c "cat > $DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=Cursor IDE
Exec=$APPIMAGE_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Categories=Development;IDE;
EOL

# Update desktop entries
echo "Updating desktop database..."
sudo update-desktop-database

echo "✅ Cursor IDE installation complete. You can launch it from the application menu."

