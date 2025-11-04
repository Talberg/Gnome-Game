/// @description Load a tower pool loadout from a JSON file and apply it to obj_tower_pool
// Uses global.current_save_slot if set, otherwise "default"

// Initialize upgrade multipliers to default values if not set
if (!variable_global_exists("damage_multiplier")) global.damage_multiplier = 1.0;
if (!variable_global_exists("range_multiplier")) global.range_multiplier = 1.0;
if (!variable_global_exists("fire_rate_multiplier")) global.fire_rate_multiplier = 1.0;
if (!variable_global_exists("cooldown_multiplier")) global.cooldown_multiplier = 1.0;

var _name = "default";
if (variable_global_exists("current_save_slot") && global.current_save_slot != "") {
    _name = global.current_save_slot;
}

var save_dir = "saves";
var filename = save_dir + "/loadout_" + _name + ".json";
if (!file_exists(filename)) {
    show_debug_message("[load_loadout] File not found: " + filename + " - creating default save");
    // Create a default save with basic gnome selected
    global.turret_selection = ["obj_tower_basic"];
    // Trigger a save to create the file (but we need obj_tower_pool to exist first)
    if (instance_exists(obj_tower_pool)) {
        scr_save_loadout();
        show_debug_message("[load_loadout] Created default save, reloading...");
        // Now try loading again
        if (!file_exists(filename)) {
            show_debug_message("[load_loadout] Failed to create default save");
            return false;
        }
    } else {
        show_debug_message("[load_loadout] Cannot create default save - no tower pool exists yet");
        return false;
    }
}

var fh = file_text_open_read(filename);
var json_text = file_text_read_string(fh);
file_text_close(fh);

var data = json_decode(json_text);
if (data == undefined) {
    show_debug_message("[load_loadout] Failed to parse JSON");
    return false;
}

if (!instance_exists(obj_tower_pool)) {
    show_debug_message("[load_loadout] No obj_tower_pool instance to apply loadout to.");
    return false;
}
var pool = instance_find(obj_tower_pool, 0);
if (pool == noone) {
    show_debug_message("[load_loadout] No obj_tower_pool instance found.");
    return false;
}

// Clear existing pool list and free maps
if (is_undefined(pool.tower_pool) == false) {
    var old = pool.tower_pool;
    var oc = ds_list_size(old);
    for (var i = 0; i < oc; i++) {
        var m = old[| i];
        if (is_undefined(m) == false && ds_exists(m, ds_type_map)) ds_map_destroy(m);
    }
    ds_list_destroy(old);
}

// Create new ds_list and populate
var new_list = ds_list_create();
var arr = data.pool;
var len = array_length(arr);
for (var i = 0; i < len; i++) {
    var s = arr[i];
    var m = ds_map_create();
    // Resolve object by name if available, fall back to stored index
    var obj_idx = -1;
    if (is_undefined(s.object_name) == false) {
        obj_idx = asset_get_index(s.object_name);
    }
    if (obj_idx == -1 && is_undefined(s.object_index) == false) {
        obj_idx = s.object_index;
    }
    if (obj_idx == -1) {
        show_debug_message("[load_loadout] Warning: could not resolve object for entry " + string(i) + ", using noone");
        obj_idx = noone;
    }
    ds_map_add(m, "object", obj_idx);
    ds_map_add(m, "name", s.name);
    ds_map_add(m, "cost", s.cost);
    ds_map_add(m, "quantity", s.quantity);
    ds_map_add(m, "max_quantity", s.max_quantity);
    ds_map_add(m, "cooldown", s.cooldown);
    ds_map_add(m, "max_cooldown", s.max_cooldown);
    ds_list_add(new_list, m);
}
pool.tower_pool = new_list;

// Restore turret selection if it was saved
if (!is_undefined(data.turret_selection)) {
    global.turret_selection = data.turret_selection;
    show_debug_message("[load_loadout] Restored turret selection: " + string(array_length(data.turret_selection)) + " turrets");
}

// Restore player level and XP if saved
if (instance_exists(obj_game_manager)) {
    var gm = obj_game_manager;
    if (!is_undefined(data.meta)) {
        if (!is_undefined(data.meta.player_level)) {
            gm.player_level = data.meta.player_level;
            gm.player_xp = !is_undefined(data.meta.player_xp) ? data.meta.player_xp : 0;
            gm.xp_to_next_level = gm.calculate_xp_for_level(gm.player_level + 1) - gm.calculate_xp_for_level(gm.player_level);
            show_debug_message("[load_loadout] Restored level " + string(gm.player_level) + " with " + string(gm.player_xp) + " XP");
        }
    }
}

// Restore upgrade multipliers if saved
if (!is_undefined(data.upgrades)) {
    if (!is_undefined(data.upgrades.damage_mult)) global.damage_multiplier = data.upgrades.damage_mult;
    if (!is_undefined(data.upgrades.range_mult)) global.range_multiplier = data.upgrades.range_mult;
    if (!is_undefined(data.upgrades.fire_rate_mult)) global.fire_rate_multiplier = data.upgrades.fire_rate_mult;
    if (!is_undefined(data.upgrades.cooldown_mult)) global.cooldown_multiplier = data.upgrades.cooldown_mult;
    show_debug_message("[load_loadout] Restored upgrade multipliers");
}

show_debug_message("[load_loadout] Loaded loadout from " + filename + " (" + string(len) + " items)");
return true;