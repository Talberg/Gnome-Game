/// @description Save the current tower pool to a JSON loadout file
/// @arg _name string - loadout name (used as filename)
var _name = argument0;
if (_name == undefined || _name == "") _name = "default";

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
meta.generated = date_format(date_current_datetime(), "%Y-%m-%dT%H:%M:%SZ");
meta.gold = obj_game_manager.gold;

var save_struct = {};
save_struct.meta = meta;
save_struct.pool = out;

var json_text = json_encode(save_struct);
var filename = "loadout_" + _name + ".json";

// Write to working directory
var fh = file_text_open_write(filename);
file_text_write_string(fh, json_text);
file_text_close(fh);

show_debug_message("[save_loadout] Saved loadout to " + filename + " (" + string(count) + " items)");
return filename;