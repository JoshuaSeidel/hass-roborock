# Roborock Integration - Extended B01 Support

[![hacs_badge](https://img.shields.io/badge/HACS-Custom-orange.svg)](https://github.com/custom-components/hacs)
[![GitHub Release](https://img.shields.io/github/release/JoshuaSeidel/hass-roborock.svg)](https://github.com/JoshuaSeidel/hass-roborock/releases)
[![GitHub Activity](https://img.shields.io/github/commit-activity/m/JoshuaSeidel/hass-roborock.svg)](https://github.com/JoshuaSeidel/hass-roborock/commits/main)
[![License](https://img.shields.io/github/license/JoshuaSeidel/hass-roborock.svg)](LICENSE)
[![Home Assistant](https://img.shields.io/badge/Home%20Assistant-2026.3%2B-blue.svg)](https://www.home-assistant.io/)

Extended version of the official Home Assistant Roborock integration with support for **B01 Q10 protocol vacuum devices**.

## The Problem This Solves

If you've seen this error in your Home Assistant logs:

```
Not adding device ... because its protocol version B01 or category VACUUM is not supported
```

**This integration fixes that!** It adds native support for B01 Q10 vacuum devices that aren't supported by the official integration.

## Supported Devices

This integration supports **all devices** from the official integration, plus:

### ✨ NEW - B01 Q10 Protocol
- Roborock vacuum devices using B01 Q10 protocol
- Previously unsupported B01 VACUUM category devices

### Already Supported (from official integration)
- **V1 Protocol**: Most standard Roborock robot vacuums
- **A01 Protocol**: Dyad wet/dry vacuums, Zeo washing machines
- **B01 Q7 Protocol**: B01 Q7 vacuum devices

## Features

All features from the official Roborock integration:

- 🧹 **Full Vacuum Control** - Start, stop, pause, return to dock
- 🗺️ **Map Visualization** - Real-time map updates with room cleaning
- 📊 **Comprehensive Sensors** - Battery, status, cleaning time, area, etc.
- 🔄 **Consumable Tracking** - Monitor filters, brushes, sensors
- ⚙️ **Advanced Settings** - Fan speed, water level, DND mode, child lock
- 📅 **Scheduling** - Create and manage cleaning schedules
- 🏠 **Multi-floor Support** - Save and manage multiple maps
- 🤖 **Full Automation** - Works with all Home Assistant automations

## Installation

### HACS (Recommended)

1. **Add Custom Repository**
   - Open HACS in Home Assistant
   - Click the three dots (⋮) in the top right
   - Select "Custom repositories"
   - Add repository: `https://github.com/JoshuaSeidel/hass-roborock`
   - Category: **Integration**
   - Click "Add"

2. **Install Integration**
   - Search for "Roborock (Extended B01 Support)" in HACS
   - Click "Download"
   - Restart Home Assistant

3. **Configure**
   - Go to Settings → Devices & Services
   - Click "+ Add Integration"
   - Search for "Roborock"
   - Follow the setup wizard

### Manual Installation

1. **Download Integration**
   ```bash
   cd /config
   wget https://github.com/JoshuaSeidel/hass-roborock/releases/download/v1.0.0/roborock-1.0.0.zip
   unzip roborock-1.0.0.zip -d custom_components/
   ```

2. **Or use the install script**
   ```bash
   git clone https://github.com/JoshuaSeidel/hass-roborock.git
   cd hass-roborock
   ./install.sh /config
   ```

3. **Restart Home Assistant**

4. **Add integration** through Settings → Devices & Services

## Requirements

- **Home Assistant**: 2026.3.0 or newer
- **Python**: 3.12+
- **Dependencies** (auto-installed):
  - python-roborock 4.17.1
  - vacuum-map-parser-roborock 0.1.4

## Configuration

No YAML configuration needed! Everything is configured through the UI.

1. Go to **Settings** → **Devices & Services**
2. Click **+ Add Integration**
3. Search for **Roborock**
4. Enter your Roborock account credentials
5. Select your region
6. Your devices will be automatically discovered

## What's Different?

### Technical Changes

**New Q10 Coordinator** (`coordinator.py`)
- Added `RoborockB01Q10UpdateCoordinator` class
- Subscription-based update model (different from Q7's query model)
- Proper initialization and shutdown handling

**Enhanced Device Detection** (`__init__.py`)
- Checks for `b01_q10_properties` attribute
- Creates appropriate coordinator for Q10 devices
- Better error messages for unsupported devices

### How It Works

The Q10 coordinator uses a different communication pattern:
1. Starts a subscription loop on initialization
2. Refreshes data by requesting all device data points
3. Receives updates asynchronously through subscriptions
4. Automatically updates status in Home Assistant

## Troubleshooting

### Device Not Detected

1. Check Home Assistant logs for errors
2. Verify device is supported (check protocol version)
3. Ensure you're using the latest version of this integration
4. Try removing and re-adding the integration

### Integration Not Showing

1. Verify files are in `custom_components/roborock`
2. Check Home Assistant logs for errors
3. Restart Home Assistant after installation
4. Clear browser cache

### Conflicts with Official Integration

This integration **replaces** the official one. If you have the official integration:
1. Remove the official Roborock integration first
2. Restart Home Assistant
3. Install this integration
4. Re-add your devices

## Development

```bash
# Clone repository
git clone https://github.com/JoshuaSeidel/hass-roborock.git
cd hass-roborock

# Install in development mode
ln -s $(pwd)/custom_components/roborock /config/custom_components/roborock

# Run validation
python3 -m py_compile custom_components/roborock/*.py
```

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/JoshuaSeidel/hass-roborock/issues)
- 💬 **Questions**: [GitHub Discussions](https://github.com/JoshuaSeidel/hass-roborock/discussions)
- 📖 **Documentation**: [Wiki](https://github.com/JoshuaSeidel/hass-roborock/wiki)

## Credits

- **Original Integration**: Home Assistant Community & Roborock team
- **B01 Q10 Support**: Joshua Seidel
- **Built with**: Claude Code
- **Based on**: Home Assistant core Roborock integration

## License

Apache 2.0 License - Same as Home Assistant core

See [LICENSE](LICENSE) for details.

## Changelog

See [RELEASE_NOTES.md](RELEASE_NOTES.md) for version history and detailed changes.

---

**⭐ If this integration helps you, consider starring the repository!**
