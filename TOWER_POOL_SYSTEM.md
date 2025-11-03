# Tower Pool UI System

## Overview

The Tower Pool UI is a deck-building style system that replaces the old click-to-place tower system. Players select towers from a limited pool at the bottom of the screen and drag them onto the grid.

## Features Implemented

### ✅ Tower Pool Panel (Bottom UI)

- **Location:** Bottom 120 pixels of screen
- **Display:** Shows 4 tower cards side-by-side
- **Each Card Shows:**
  - Tower preview (colored gnome icon)
  - Tower name
  - Quantity available (x/max)
  - Cooldown timer (if on cooldown)
  - Cost in gold (if applicable)

### ✅ Tower Pool Data

Starting loadout:

- **Basic Gnome:** 5 uses, 3 second cooldown (180 frames)
- **Rapid Fire Gnome:** 3 uses, 4 second cooldown (240 frames)
- **Sniper Gnome:** 2 uses, 6 second cooldown (360 frames)
- **Bomb Gnome:** 1 use, 8 second cooldown (480 frames)

### ✅ Drag and Drop Mechanics

1. **Click** on a tower card to start dragging
2. **Drag** over the grid - shows tower preview at mouse position
3. **Release** on a valid grid cell to place
4. **Right-click** to cancel drag

### ✅ Placement Validation

- **Green highlight:** Valid placement spot
- **Red highlight + X:** Invalid placement (occupied cell)
- Grid cells update in real-time during drag

### ✅ Resource Management

- Towers cost gold (currently set to 0 for testing)
- Limited quantities per tower type
- Cooldown timers prevent spam placement
- Visual feedback for unavailable towers (grayed out)

### ✅ Visual States

- **Available:** Full color, normal opacity
- **Selected:** Yellow border, highlighted
- **Hovering:** White border
- **Unavailable:** Gray, 50% opacity (no quantity, on cooldown, or not enough gold)
- **Dragging:** Semi-transparent preview follows mouse

## How to Use

### For Players:

1. Click on a tower card at the bottom
2. Drag to the grid
3. Drop on a green (valid) cell to place
4. Wait for cooldown before placing that tower type again
5. Right-click to remove towers from grid

### For Developers:

The tower pool system is modular and data-driven:

```gml
// Add towers to pool in obj_tower_pool Create event
add_tower_to_pool(
    obj_tower_basic,    // Tower object
    "Basic Gnome",      // Display name
    0,                  // Gold cost per placement
    c_green,            // Tower color
    5,                  // Starting quantity
    5,                  // Max quantity
    0,                  // Current cooldown
    180                 // Max cooldown (frames)
);
```

## Integration Points

### obj_tower_pool

- Manages tower data and UI display
- Handles card selection and drag state
- Updates cooldown timers
- Draws the bottom panel (Draw_64 event)

### obj_grid_manager

- Detects when tower pool is dragging
- Handles placement on mouse release
- Validates placement locations
- Deducts quantities and applies cooldowns
- Shows visual feedback during drag

### obj_game_manager

- Tracks gold for tower costs
- Updated UI to show range toggle hint

## Next Steps (TODO)

- [ ] Implement drag-and-drop placement _(Nearly complete - needs polish)_
- [ ] Add tower pool limitations _(Already implemented!)_
- [ ] Create tower card/icon graphics _(Using placeholder gnomes for now)_
- [ ] Add placement validation feedback _(Already implemented!)_
- [ ] Tower recall/removal system _(Removal works, recall needs implementation)_
- [ ] Add loadout save/load system
- [ ] Tower unlock progression

## Files Created/Modified

### New Files:

- `objects/obj_tower_pool/` - Tower pool manager object
  - `Create_0.gml` - Initialize pool with starting towers
  - `Step_0.gml` - Update cooldowns and handle mouse interaction
  - `Draw_64.gml` - Draw UI panel and tower cards
  - `CleanUp_0.gml` - Clean up data structures
  - `obj_tower_pool.yy` - Object definition
- `scripts/scr_tower_pool_helpers/scr_tower_pool_helpers.gml` - Helper function for adding towers

### Modified Files:

- `objects/obj_grid_manager/Step_0.gml` - Integrated with tower pool drag system
- `objects/obj_grid_manager/Draw_0.gml` - Added placement validation visuals
- `objects/obj_game_manager/Draw_64.gml` - Added range toggle hint
- `rooms/Room1/Room1.yy` - Added obj_tower_pool instance
- `Gmome Attack.yyp` - Registered new objects and scripts

## Technical Details

### Data Structure

Tower pool uses a ds_list of ds_maps:

```
tower_pool (ds_list)
  ├─ [0] tower_data (ds_map)
  │   ├─ "object": obj_tower_basic
  │   ├─ "name": "Basic Gnome"
  │   ├─ "cost": 0
  │   ├─ "color": c_green
  │   ├─ "quantity": 5
  │   ├─ "max_quantity": 5
  │   ├─ "cooldown": 0
  │   └─ "max_cooldown": 180
  └─ [1-3] ... more towers
```

### Coordinate Systems

- **Room coordinates:** Used for tower placement (mouse_x, mouse_y)
- **GUI coordinates:** Used for UI panel (device_mouse_x_to_gui)
- **Grid coordinates:** Converted from room coordinates for cell indexing

## Testing Notes

- Tower placement now only works through drag-and-drop
- Old left-click placement code has been replaced
- Cooldowns activate after each placement
- Quantity decrements after each placement
- Press R to toggle tower range circles
