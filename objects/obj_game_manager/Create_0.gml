/// @description Game Manager Initialization

// Player resources
gold = 300; // Increased starting gold for tower purchases
lives = 20;

// Wave system
current_wave = 0;
wave_in_progress = false;

// Game state
game_over = false;
game_won = false;

// Level & XP system
player_level = 1;
player_xp = 0;
xp_to_next_level = 50; // XP needed for level 2 (reduced from 100)

// XP curve: moderate scaling - level up every 1-2 waves early game
max_level = 20;

// Calculate XP needed for a given level
function calculate_xp_for_level(level) {
    if (level <= 1) return 0;
    if (level > max_level) return 999999;
    // Formula: 50 * (1.15 ^ (level - 1)) - slower scaling than before
    return floor(50 * power(1.15, level - 1));
}

// Award XP and check for level-up
function gain_xp(amount) {
    if (player_level >= max_level) return; // Max level reached
    
    player_xp += amount;
    show_debug_message("[XP] Gained " + string(amount) + " XP (total: " + string(player_xp) + "/" + string(xp_to_next_level) + ")");
    
    // Check for level-up
    while (player_xp >= xp_to_next_level && player_level < max_level) {
        player_level += 1;
        player_xp -= xp_to_next_level;
        xp_to_next_level = calculate_xp_for_level(player_level + 1) - calculate_xp_for_level(player_level);
        
        show_debug_message("[LEVEL UP] Now level " + string(player_level) + "!");
        
        // Trigger level-up menu
        if (!instance_exists(obj_level_up_menu)) {
            instance_create_depth(0, 0, -10000, obj_level_up_menu);
        }
    }
}
