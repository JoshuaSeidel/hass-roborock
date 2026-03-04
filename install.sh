#!/bin/bash
# Roborock B01 Q10 Integration Installation Script

set -e

echo "========================================="
echo "Roborock B01 Q10 Integration Installer"
echo "========================================="
echo ""

# Check if running as root (not recommended for Home Assistant)
if [ "$EUID" -eq 0 ]; then
    echo "Warning: Running as root. Make sure this is intended."
fi

# Determine Home Assistant config directory
if [ -n "$1" ]; then
    HA_CONFIG_DIR="$1"
elif [ -d "/config" ]; then
    HA_CONFIG_DIR="/config"
elif [ -d "$HOME/.homeassistant" ]; then
    HA_CONFIG_DIR="$HOME/.homeassistant"
else
    echo "Error: Could not find Home Assistant config directory."
    echo "Usage: $0 [config_directory]"
    echo "Example: $0 /config"
    echo "Example: $0 ~/.homeassistant"
    exit 1
fi

echo "Home Assistant config directory: $HA_CONFIG_DIR"
echo ""

# Create custom_components directory if it doesn't exist
CUSTOM_DIR="$HA_CONFIG_DIR/custom_components"
if [ ! -d "$CUSTOM_DIR" ]; then
    echo "Creating custom_components directory..."
    mkdir -p "$CUSTOM_DIR"
fi

# Backup existing roborock integration if it exists
ROBOROCK_DIR="$CUSTOM_DIR/roborock"
if [ -d "$ROBOROCK_DIR" ]; then
    BACKUP_DIR="$ROBOROCK_DIR.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backing up existing roborock integration to: $BACKUP_DIR"
    cp -r "$ROBOROCK_DIR" "$BACKUP_DIR"
fi

# Copy the integration
echo "Installing Roborock integration with B01 Q10 support..."
cp -r "$(dirname "$0")/custom_components/roborock" "$CUSTOM_DIR/"

# Set proper permissions
chmod -R 755 "$ROBOROCK_DIR"

echo ""
echo "========================================="
echo "Installation Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "1. Restart Home Assistant"
echo "2. Your B01 Q10 vacuum should be automatically detected"
echo "3. Check Configuration > Devices & Services > Roborock"
echo ""
echo "If you encounter issues, check the Home Assistant logs:"
echo "  Settings > System > Logs"
echo ""
echo "Backup location (if applicable): $BACKUP_DIR"
echo ""
