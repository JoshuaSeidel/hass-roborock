# Roborock Integration - Extended B01 Support

[![hacs_badge](https://img.shields.io/badge/HACS-Custom-orange.svg)](https://github.com/custom-components/hacs)
[![GitHub Release](https://img.shields.io/github/release/JoshuaSeidel/hass-roborock.svg)](https://github.com/JoshuaSeidel/hass-roborock/releases)
[![License](https://img.shields.io/github/license/JoshuaSeidel/hass-roborock.svg)](LICENSE)

## What's New

This custom integration extends the official Home Assistant Roborock integration with support for **B01 Q10 protocol vacuum devices**.

### Supported Devices

✅ **All official integration devices:**
- V1 Protocol vacuums (most standard Roborock robot vacuums)
- A01 Protocol devices (Dyad wet/dry vacuums, Zeo washing machines)
- B01 Q7 Protocol vacuums

✨ **NEW - Now also supports:**
- **B01 Q10 Protocol vacuums** - Previously unsupported devices showing "protocol version B01 or category VACUUM is not supported"

## Why This Integration?

If you've seen this error in your Home Assistant logs:
```
Not adding device ... because its protocol version B01 or category VACUUM is not supported
```

This integration solves that problem by adding native support for B01 Q10 vacuum devices.

## Features

All features from the official Roborock integration, including:
- 🧹 Vacuum control (start, stop, pause, return to dock)
- 🗺️ Map support with room cleaning
- 📊 Sensors (battery, cleaning status, error states, etc.)
- ⚙️ Switches and controls (DND mode, child lock, etc.)
- 🔘 Buttons (find robot, reset consumables, etc.)
- 📅 Scheduling and timers
- 🏠 Multi-floor map support

## Installation

### Via HACS (Recommended)

1. Add this repository to HACS as a custom repository:
   - HACS → Integrations → ⋮ → Custom repositories
   - Repository: `https://github.com/JoshuaSeidel/hass-roborock`
   - Category: Integration
2. Click "Install"
3. Restart Home Assistant
4. Configure via UI: Settings → Devices & Services → Add Integration → Roborock

### Manual Installation

1. Download the latest release
2. Extract to `custom_components/roborock` in your config directory
3. Restart Home Assistant
4. Configure via UI

## Configuration

Configuration is done entirely through the UI. No YAML configuration needed.

1. Go to Settings → Devices & Services
2. Click "+ Add Integration"
3. Search for "Roborock"
4. Follow the setup wizard

## Compatibility

- **Home Assistant:** 2026.3.0 or newer
- **Python:** 3.12+
- **Roborock Library:** python-roborock 4.17.1+

## Support

For issues, questions, or feature requests:
- 🐛 [Report an issue](https://github.com/JoshuaSeidel/hass-roborock/issues)
- 💬 [Discussions](https://github.com/JoshuaSeidel/hass-roborock/discussions)

## Credits

Based on the official Home Assistant Roborock integration with extensions for B01 Q10 device support.

## License

Apache 2.0 License (same as Home Assistant core)
