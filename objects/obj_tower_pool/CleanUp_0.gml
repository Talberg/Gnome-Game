/// @description Cleanup

// Clean up tower pool data
for (var i = 0; i < ds_list_size(tower_pool); i++) {
    var tower_data = tower_pool[| i];
    ds_map_destroy(tower_data);
}
ds_list_destroy(tower_pool);
