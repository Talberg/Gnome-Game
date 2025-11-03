/// @description Load a tower pool loadout from a JSON file and apply it to obj_tower_pool
/// @arg _name string - loadout name (filename without prefix)
var _name = argument0;
if (_name == undefined || _name == "") _name = "default";

var filename = "loadout_" + _name + ".json";
if (!file_exists(filename)) {
    show_debug_message("[load_loadout] File not found: " + filename);
    return false;
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

show_debug_message("[load_loadout] Loaded loadout from " + filename + " (" + string(len) + " items)");
return true;