/// @description Save the current tower pool to a JSON loadout file
// Uses global.current_save_slot if set, otherwise "default"
var _name = "default";
if (variable_global_exists("current_save_slot") && global.current_save_slot != "") {
    _name = global.current_save_slot;
}

if (!instance_exists(obj_tower_pool)) {
    show_debug_message("[save_loadout] No tower pool (obj_tower_pool) found. Save aborted.");
    return;
}

var pool = instance_find(obj_tower_pool, 0);
if (pool == noone) {
    show_debug_message("[save_loadout] No tower pool instance found.");
    return;
}

// Build an array of structs representing the pool
var out = [];
var list = pool.tower_pool;
var count = ds_list_size(list);
for (var i = 0; i < count; i++) {
    var td = list[| i];
    var entry = {};
    // Save object name (safer across sessions) and keep index for reference
    var obj_index = td[? "object"];
    var obj_name = asset_get_name(obj_index);
    entry.object_name = obj_name;
    entry.object_index = obj_index;
    entry.name = td[? "name"];
    entry.cost = td[? "cost"];
    entry.quantity = td[? "quantity"];
    entry.max_quantity = td[? "max_quantity"];
    entry.cooldown = td[? "cooldown"];
    entry.max_cooldown = td[? "max_cooldown"];
    array_push(out, entry);
}

// Also save some global/game state that may be useful
var meta = {};
meta.generated = date_datetime_string(date_current_datetime());
meta.gold = obj_game_manager.gold;
meta.player_level = obj_game_manager.player_level;
meta.player_xp = obj_game_manager.player_xp;

// Save turret selection if it exists
var turret_sel = [];
if (variable_global_exists("turret_selection") && is_array(global.turret_selection)) {
    turret_sel = global.turret_selection;
}

// Save global upgrade multipliers
var upgrades = {};
upgrades.damage_mult = variable_global_exists("damage_multiplier") ? global.damage_multiplier : 1.0;
upgrades.range_mult = variable_global_exists("range_multiplier") ? global.range_multiplier : 1.0;
upgrades.fire_rate_mult = variable_global_exists("fire_rate_multiplier") ? global.fire_rate_multiplier : 1.0;
upgrades.cooldown_mult = variable_global_exists("cooldown_multiplier") ? global.cooldown_multiplier : 1.0;

var save_struct = {};
save_struct.meta = meta;
save_struct.pool = out;
save_struct.turret_selection = turret_sel;
save_struct.upgrades = upgrades;

var json_text = json_encode(save_struct);

// Ensure saves directory exists and write into it
var save_dir = "saves";
if (!directory_exists(save_dir)) {
    var ok = directory_create(save_dir);
    if (!ok) show_debug_message("[save_loadout] Warning: could not create saves directory '" + save_dir + "'");
}
var filename = save_dir + "/loadout_" + _name + ".json";

// Write JSON to file
var fh = -1;
try {
    fh = file_text_open_write(filename);
} catch (e) {
    show_debug_message("[save_loadout] Error opening file for write: " + filename);
    return undefined;
}
file_text_write_string(fh, json_text);
file_text_close(fh);

show_debug_message("[save_loadout] Saved loadout to " + filename + " (" + string(count) + " items)");
return filename;