# Roborock Integration with B01 Q10 Support

This is an updated version of the official Home Assistant Roborock integration that adds support for B01 protocol Q10 vacuum devices.

## What Changed

The official Roborock integration from Home Assistant only supported:
- V1 protocol vacuums (most standard robot vacuums)
- A01 protocol devices (Dyad wet/dry vacuums and Zeo washing machines)
- B01 Q7 protocol vacuums

This update adds support for:
- **B01 Q10 protocol vacuums** - Including devices with protocol version B01 and category VACUUM that were previously unsupported

## Changes Made

### 1. `coordinator.py`
- Added import for `Q10PropertiesApi` from `roborock.devices.traits.b01.q10`
- Updated `RoborockCoordinators` dataclass to include `b01_q10` coordinator list
- Added new `RoborockB01Q10UpdateCoordinator` class to handle Q10 devices
- The Q10 coordinator uses a subscription-based update model instead of query-based

### 2. `__init__.py`
- Added import for `RoborockB01Q10UpdateCoordinator`
- Updated `build_setup_functions` to check for `device.b01_q10_properties` and create Q10 coordinators
- Updated coordinator gathering logic to include `b01_q10_coords`
- Updated `setup_coordinator` to call `_async_setup()` for coordinators that need initialization
- Updated type hints throughout to include the new coordinator type

## Installation

### Option 1: Custom Component (Recommended)

1. Copy the `custom_components/roborock` directory to your Home Assistant `custom_components` folder:
   ```bash
   cp -r custom_components/roborock /config/custom_components/
   ```

2. Restart Home Assistant

3. Your B01 Q10 vacuum should now be detected and added automatically

### Option 2: Replace Core Integration (Advanced)

⚠️ **Warning**: This will modify your Home Assistant core files. Use with caution.

1. Locate your Home Assistant core installation directory
2. Navigate to `homeassistant/components/roborock/`
3. Backup the existing files:
   ```bash
   cp __init__.py __init__.py.backup
   cp coordinator.py coordinator.py.backup
   ```
4. Copy the updated files:
   ```bash
   cp custom_components/roborock/__init__.py homeassistant/components/roborock/
   cp custom_components/roborock/coordinator.py homeassistant/components/roborock/
   ```
5. Restart Home Assistant

## Supported Devices

This integration now supports:

### V1 Protocol
- Most standard Roborock robot vacuums
- Local and cloud API support

### A01 Protocol
- Roborock Dyad (wet/dry vacuums)
- Roborock Zeo (washing machines)

### B01 Protocol
- **B01 Q7** - Previously supported
- **B01 Q10** - ✨ NEW! Now supported

## Troubleshooting

If your device is still not detected:

1. Check Home Assistant logs for the error message
2. Look for: `"Not adding device ... because its protocol version ... or category ... is not supported"`
3. Note the protocol version and category
4. If it's a different B01 variant, you may need to add support for that specific model

## Technical Details

### Q10 Device Properties

The Q10 coordinator accesses the following device properties through the Q10PropertiesApi:
- `status` - Device status including battery, fan level, water level, cleaning mode, etc.
- `command` - Command trait for sending commands to the device
- `vacuum` - Vacuum-specific commands

The Q10 uses a subscription-based model where:
1. The coordinator starts a subscription loop via `api.start()`
2. Data is refreshed by calling `api.refresh()` which requests all DPS (Data Point) values
3. Updates are received asynchronously through the subscription loop
4. The status trait is automatically updated with new values

## Dependencies

This integration requires:
- `python-roborock>=4.17.1` - Includes Q10 support
- `vacuum-map-parser-roborock>=0.1.4`

These are automatically included in the manifest.json.

## Contributing

If you find issues or have improvements, please contribute back to the Home Assistant core repository at:
https://github.com/home-assistant/core

## License

This integration follows the same license as Home Assistant core (Apache 2.0).

## Credits

- Original Roborock integration: Home Assistant Community
- B01 Q10 support added by: Claude Code
- Based on Home Assistant core version: dev branch (2025-03-04)
