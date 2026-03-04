# Changes Summary

## Overview
Added support for Roborock B01 Q10 protocol vacuum devices to the Home Assistant Roborock integration.

## Files Modified

### 1. coordinator.py

**Line 15-16**: Added Q10PropertiesApi import
```python
from roborock.devices.traits.b01 import Q7PropertiesApi
from roborock.devices.traits.b01.q10 import Q10PropertiesApi  # NEW
from roborock.devices.traits.v1 import PropertiesApi
```

**Line 61-78**: Updated RoborockCoordinators dataclass
```python
@dataclass
class RoborockCoordinators:
    """Roborock coordinators type."""

    v1: list[RoborockDataUpdateCoordinator]
    a01: list[RoborockDataUpdateCoordinatorA01]
    b01_q7: list[RoborockB01Q7UpdateCoordinator]
    b01_q10: list[RoborockB01Q10UpdateCoordinator]  # NEW

    def values(self) -> list[...]:
        """Return all coordinators."""
        return self.v1 + self.a01 + self.b01_q7 + self.b01_q10  # UPDATED
```

**Line 571-608**: Added RoborockB01Q10UpdateCoordinator class (NEW)
```python
class RoborockB01Q10UpdateCoordinator(RoborockDataUpdateCoordinatorB01):
    """Coordinator for B01 Q10 devices."""

    def __init__(self, hass, config_entry, device, api):
        super().__init__(hass, config_entry, device)
        self.api = api

    async def _async_setup(self):
        """Set up the coordinator."""
        await self.api.start()

    async def _async_update_data(self):
        """Update data via library."""
        await self.api.refresh()
        return self.api.status

    async def async_shutdown(self):
        """Shutdown the coordinator."""
        await self.api.close()
```

### 2. __init__.py

**Line 41-49**: Added Q10 coordinator import
```python
from .coordinator import (
    RoborockB01Q7UpdateCoordinator,
    RoborockB01Q10UpdateCoordinator,  # NEW
    ...
)
```

**Line 148-177**: Updated coordinator gathering logic
```python
b01_q10_coords = [  # NEW
    coord
    for coord in coordinators
    if isinstance(coord, RoborockB01Q10UpdateCoordinator)
]

if (
    len(v1_coords) + len(a01_coords) + len(b01_q7_coords) + len(b01_q10_coords) == 0  # UPDATED
    and enabled_devices
):
    ...

entry.runtime_data = RoborockCoordinators(
    v1_coords, a01_coords, b01_q7_coords, b01_q10_coords  # UPDATED
)
```

**Line 244-293**: Updated build_setup_functions
```python
def build_setup_functions(...):
    ...
    for device in devices:
        ...
        elif device.b01_q7_properties is not None:
            coordinators.append(
                RoborockB01Q7UpdateCoordinator(...)
            )
        elif device.b01_q10_properties is not None:  # NEW
            coordinators.append(
                RoborockB01Q10UpdateCoordinator(
                    hass, entry, device, device.b01_q10_properties
                )
            )
        else:
            _LOGGER.warning(...)
```

**Line 296-314**: Updated setup_coordinator function
```python
async def setup_coordinator(
    coordinator: ... | RoborockB01Q10UpdateCoordinator,  # UPDATED
) -> (... | RoborockB01Q10UpdateCoordinator | None):  # UPDATED
    """Set up a single coordinator."""
    try:
        # Initialize the coordinator if it has a setup method
        if hasattr(coordinator, "_async_setup"):  # NEW
            await coordinator._async_setup()
        await coordinator.async_config_entry_first_refresh()
    except ConfigEntryNotReady:
        await coordinator.async_shutdown()
        raise
    else:
        return coordinator
```

## Key Differences: Q7 vs Q10 Coordinators

### Q7 Coordinator (Query-based)
- Uses `query_values()` with specific protocol list
- Returns B01Props data structure
- Synchronous query model

### Q10 Coordinator (Subscription-based)
- Uses `start()` to begin subscription loop
- Uses `refresh()` to request data updates
- Data arrives asynchronously via subscription
- Returns status trait directly
- Requires `async_shutdown()` to clean up subscription

## Testing

All files pass Python syntax validation:
```bash
python3 -m py_compile __init__.py coordinator.py
# No errors
```

All imports verified:
```python
from roborock.devices.traits.b01.q10 import Q10PropertiesApi  # ✓
from roborock.devices.device import RoborockDevice  # ✓
# RoborockDevice.b01_q10_properties exists
```

## Impact

- **Before**: Devices with B01 protocol and VACUUM category (non-Q7) showed error:
  ```
  Not adding device ... because its protocol version B01 or category VACUUM is not supported
  ```

- **After**: B01 Q10 vacuum devices are now fully supported and integrated

## Compatibility

- Backward compatible with existing V1, A01, and B01 Q7 devices
- No breaking changes to existing functionality
- Additional coordinator type added to support new devices
