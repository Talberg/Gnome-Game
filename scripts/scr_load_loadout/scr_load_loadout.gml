/// @description Load a tower pool loadout from a JSON file and apply it to obj_tower_pool
// Uses global.current_save_slot if set, otherwise "default"
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

show_debug_message("[load_loadout] Loaded loadout from " + filename + " (" + string(len) + " items)");
return true;