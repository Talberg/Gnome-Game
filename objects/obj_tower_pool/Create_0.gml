/// @description Tower Pool Manager Initialization

// Tower pool data structure
// Each entry: [object_index, name, cost, color, quantity, max_quantity, cooldown, max_cooldown]
tower_pool = ds_list_create();

// Initialize the player's tower loadout
// Towers have infinite uses, limited only by cooldown and gold cost
// Set quantity to -1 for infinite uses (display shows "∞")
add_tower_to_pool(obj_tower_basic, "Basic Gnome", 50, c_green, -1, -1, 0, 180);      // Infinite uses, 3 sec cooldown, 50 gold
add_tower_to_pool(obj_tower_rapid, "Rapid Gnome", 75, c_orange, -1, -1, 0, 240);     // Infinite uses, 4 sec cooldown, 75 gold
add_tower_to_pool(obj_tower_sniper, "Sniper Gnome", 100, c_blue, -1, -1, 0, 360);    // Infinite uses, 6 sec cooldown, 100 gold
add_tower_to_pool(obj_tower_bomb, "Bomb Gnome", 150, c_red, -1, -1, 0, 480);         // Infinite uses, 8 sec cooldown, 150 gold

// UI Layout
panel_height = 120;
panel_y = room_height - panel_height;
card_width = 140;
card_height = 100;
card_padding = 10;
card_start_x = 50;

// Selected tower for placement
selected_tower_index = -1; // Which card is selected (-1 = none)
hovering_card = -1; // Which card mouse is over

// Drag state
is_dragging = false;
drag_tower_object = noone;
drag_start_x = 0;
drag_start_y = 0;
