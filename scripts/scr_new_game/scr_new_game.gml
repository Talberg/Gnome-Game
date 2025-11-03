/// @description Initialize a fresh new game state
/// Resets common globals and prepares for a new run. Call before going to the gameplay room.

// Reset UI flags
global.show_ranges = false;

// If you add more persistent globals later, reset them here (examples):
// global.unlocked_towers = ds_list_create();
// global.player_profile = undefined;

// Return true for convenience
return true;
