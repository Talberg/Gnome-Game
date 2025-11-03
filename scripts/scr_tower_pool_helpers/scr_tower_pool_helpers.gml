/// @description Helper function to add tower to pool
/// @param object The tower object
/// @param name Tower display name
/// @param cost Gold cost per placement
/// @param color Tower color
/// @param quantity Current available quantity
/// @param max_quantity Maximum quantity
/// @param cooldown Current cooldown timer
/// @param max_cooldown Maximum cooldown time

function add_tower_to_pool(_obj, _name, _cost, _color, _qty, _max_qty, _cd, _max_cd) {
    var tower_data = ds_map_create();
    ds_map_add(tower_data, "object", _obj);
    ds_map_add(tower_data, "name", _name);
    ds_map_add(tower_data, "cost", _cost);
    ds_map_add(tower_data, "color", _color);
    ds_map_add(tower_data, "quantity", _qty);
    ds_map_add(tower_data, "max_quantity", _max_qty);
    ds_map_add(tower_data, "cooldown", _cd);
    ds_map_add(tower_data, "max_cooldown", _max_cd);
    
    ds_list_add(tower_pool, tower_data);
    
    return ds_list_size(tower_pool) - 1; // Return index
}
