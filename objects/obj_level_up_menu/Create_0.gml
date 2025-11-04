/// @description Level-Up Menu Initialization

// Get current level from game manager
if (instance_exists(obj_game_manager)) {
    level_reached = obj_game_manager.player_level;
} else {
    level_reached = 1;
}

// Menu layout
menu_x = room_width / 2 - 400;
menu_y = room_height / 2 - 250;
menu_w = 800;
menu_h = 500;

title = "LEVEL UP!";
subtitle = "Level " + string(level_reached) + " - Choose Your Reward";

// Generate 3 random reward options
reward_options = [];

// Reward types pool
var reward_pool = [
    { type: "unlock_turret", label: "Unlock Turret", desc: "Add a new turret type to your pool" },
    { type: "damage_boost", label: "+10% Damage", desc: "All towers deal 10% more damage" },
    { type: "range_boost", label: "+15% Range", desc: "All towers have 15% longer range" },
    { type: "fire_rate_boost", label: "+10% Fire Rate", desc: "All towers shoot 10% faster" },
    { type: "gold_bonus", label: "+100 Gold", desc: "Instant gold reward" },
    { type: "extra_life", label: "+1 Life", desc: "Gain one extra life" },
    { type: "cooldown_reduce", label: "-20% Cooldown", desc: "Tower placement cooldowns reduced" }
];

// Pick 3 unique random rewards
var pool_copy = [];
for (var i = 0; i < array_length(reward_pool); i++) {
    array_push(pool_copy, reward_pool[i]);
}

for (var i = 0; i < 3 && array_length(pool_copy) > 0; i++) {
    var idx = irandom(array_length(pool_copy) - 1);
    array_push(reward_options, pool_copy[idx]);
    array_delete(pool_copy, idx, 1);
}

// Card layout
card_w = 220;
card_h = 180;
card_gap = 40;
card_start_x = menu_x + (menu_w - (card_w * 3 + card_gap * 2)) / 2;
card_start_y = menu_y + 150;

hover_card = -1;
