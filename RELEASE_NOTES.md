# Release Notes

## Version 1.0.0 (2026-03-04)

### Initial Release

This is the first release of the extended Roborock integration with B01 Q10 protocol support.

### What's New

✨ **B01 Q10 Protocol Support**
- Added support for Roborock vacuum devices using the B01 Q10 protocol
- Devices that previously showed "protocol version B01 or category VACUUM is not supported" will now work

### Features

All features from the official Home Assistant Roborock integration:
- ✅ Full vacuum control (start, stop, pause, dock)
- ✅ Real-time status monitoring
- ✅ Map visualization and room cleaning
- ✅ Consumable tracking (filters, brushes, sensors)
- ✅ Advanced settings (DND mode, child lock, fan speed, water level)
- ✅ Multi-floor map support
- ✅ Scheduling and automation support

### Technical Changes

**coordinator.py:**
- Added `RoborockB01Q10UpdateCoordinator` class
- Implemented subscription-based update model for Q10 devices
- Updated `RoborockCoordinators` dataclass to include Q10 coordinators

**__init__.py:**
- Added device detection for `b01_q10_properties`
- Updated coordinator setup logic
- Enhanced error handling for unsupported devices

### Requirements

- **Home Assistant:** 2026.3.0 or newer
- **Python:** 3.12+
- **Dependencies:**
  - python-roborock 4.17.1
  - vacuum-map-parser-roborock 0.1.4

### Installation

#### Via HACS (Recommended)
1. Add custom repository: `https://github.com/JoshuaSeidel/hass-roborock`
2. Install through HACS
3. Restart Home Assistant
4. Add integration through UI

#### Manual Installation
1. Download `roborock-1.0.0.zip` from releases
2. Extract to `custom_components/roborock`
3. Restart Home Assistant
4. Add integration through UI

### Known Issues

None at this time.

### Credits

- Based on the official Home Assistant Roborock integration
- Extended B01 Q10 support by Joshua Seidel
- Built with assistance from Claude Code

### Support

- 🐛 Report issues: https://github.com/JoshuaSeidel/hass-roborock/issues
- 💬 Discussions: https://github.com/JoshuaSeidel/hass-roborock/discussions
- 📖 Documentation: https://github.com/JoshuaSeidel/hass-roborock

### License

Apache 2.0 License (same as Home Assistant core)
