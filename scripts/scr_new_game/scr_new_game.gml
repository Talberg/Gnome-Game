/// @description Initialize a fresh new game state
/// Resets common globals and prepares for a new run. Call before going to the gameplay room.

// Reset UI flags
global.show_ranges = false;

// Initialize upgrade multipliers (these persist and stack through level-ups)
global.damage_multiplier = 1.0;
global.range_multiplier = 1.0;
global.fire_rate_multiplier = 1.0;
global.cooldown_multiplier = 1.0;

// If you add more persistent globals later, reset them here (examples):
// global.unlocked_towers = ds_list_create();
// global.player_profile = undefined;

// Return true for convenience
return true;
