/// @description Tower Pool Manager Initialization

// Tower pool data structure
// Each entry: [object_index, name, cost, color, quantity, max_quantity, cooldown, max_cooldown]
tower_pool = ds_list_create();

// Debug: report when the pool is initialized and whether turret selection data arrived
show_debug_message("[tower_pool] Create: room id=" + string(room));
if (variable_global_exists("turret_selection")) {
	if (is_array(global.turret_selection)) show_debug_message("[tower_pool] global.turret_selection length=" + string(array_length(global.turret_selection)));
	else show_debug_message("[tower_pool] global.turret_selection exists but is not an array (type=" + string(typeof(global.turret_selection)) + ")");
} else {
	show_debug_message("[tower_pool] no global.turret_selection present; using default pool");
}

// Initialize the player's tower loadout
// If the player came from the turret selection screen, use that selection
// `global.turret_selection` is expected to be an array of object names (e.g. "obj_tower_basic").
if (variable_global_exists("turret_selection") && is_array(global.turret_selection) && array_length(global.turret_selection) > 0) {
	// Use the player's chosen turrets in the same order
	for (var i = 0; i < array_length(global.turret_selection); i++) {
		var entry = global.turret_selection[i];
		var obj_idx = -1;
		if (is_string(entry)) {
			obj_idx = asset_get_index(entry);
		} else if (is_real(entry)) {
			obj_idx = entry;
		}

		// Map known object names to their display data/stats. Fall back to a basic gnome if unknown.
		if (obj_idx == asset_get_index("obj_tower_basic") || entry == "obj_tower_basic") {
			add_tower_to_pool(obj_tower_basic, "Basic Gnome", 50, c_green, -1, -1, 0, 180);
		} else if (obj_idx == asset_get_index("obj_tower_rapid") || entry == "obj_tower_rapid") {
			add_tower_to_pool(obj_tower_rapid, "Rapid Gnome", 75, c_orange, -1, -1, 0, 240);
		} else if (obj_idx == asset_get_index("obj_tower_sniper") || entry == "obj_tower_sniper") {
			add_tower_to_pool(obj_tower_sniper, "Sniper Gnome", 100, c_blue, -1, -1, 0, 360);
		} else if (obj_idx == asset_get_index("obj_tower_bomb") || entry == "obj_tower_bomb") {
			add_tower_to_pool(obj_tower_bomb, "Bomb Gnome", 150, c_red, -1, -1, 0, 480);
		} else {
			// Unknown selection, add a Basic Gnome as fallback
			show_debug_message("[tower_pool] Unknown turret selection '" + string(entry) + "' - adding Basic Gnome as fallback.");
			add_tower_to_pool(obj_tower_basic, "Basic Gnome", 50, c_green, -1, -1, 0, 180);
		}
	}
} else {
	// Default starting pool
	// Towers have infinite uses, limited only by cooldown and gold cost
	// Set quantity to -1 for infinite uses (display shows "∞")
	add_tower_to_pool(obj_tower_basic, "Basic Gnome", 50, c_green, -1, -1, 0, 180);      // Infinite uses, 3 sec cooldown, 50 gold
	add_tower_to_pool(obj_tower_rapid, "Rapid Gnome", 75, c_orange, -1, -1, 0, 240);     // Infinite uses, 4 sec cooldown, 75 gold
	add_tower_to_pool(obj_tower_sniper, "Sniper Gnome", 100, c_blue, -1, -1, 0, 360);    // Infinite uses, 6 sec cooldown, 100 gold
	add_tower_to_pool(obj_tower_bomb, "Bomb Gnome", 150, c_red, -1, -1, 0, 480);         // Infinite uses, 8 sec cooldown, 150 gold
}

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
