/// @description Handle tower placement

// Toggle range display with R key
if (keyboard_check_pressed(ord("R"))) {
    global.show_ranges = !global.show_ranges;
}

// Check if tower pool is dragging and mouse is released
if (instance_exists(obj_tower_pool) && obj_tower_pool.is_dragging && mouse_check_button_released(mb_left)) {
    // Convert mouse position to grid coordinates
    var mouse_grid_x = floor((mouse_x - grid_start_x) / cell_size);
    var mouse_grid_y = floor((mouse_y - grid_start_y) / cell_size);
    
    // Check if drop is within grid bounds
    if (mouse_grid_x >= 0 && mouse_grid_x < grid_cols && 
        mouse_grid_y >= 0 && mouse_grid_y < grid_rows) {
        
        // Check if cell is empty
        if (ds_grid_get(grid, mouse_grid_x, mouse_grid_y) == 0) {
            // Calculate world position for the tower
            var tower_x = grid_start_x + (mouse_grid_x * cell_size) + (cell_size / 2);
            var tower_y = grid_start_y + (mouse_grid_y * cell_size) + (cell_size / 2);
            
            // Get the tower data from the pool
            var tower_index = obj_tower_pool.selected_tower_index;
            var tower_data = obj_tower_pool.tower_pool[| tower_index];
            var tower_object = tower_data[? "object"];
            var tower_cost = tower_data[? "cost"];
            
            // Check if we have enough gold
            if (obj_game_manager.gold >= tower_cost) {
                // Create the tower
                var tower = instance_create_depth(tower_x, tower_y, -100, tower_object);
                tower.grid_x = mouse_grid_x;
                tower.grid_y = mouse_grid_y;
                
                // Mark cell as occupied
                ds_grid_set(grid, mouse_grid_x, mouse_grid_y, 1);
                ds_grid_set(tower_grid, mouse_grid_x, mouse_grid_y, tower);
                
                // Deduct cost and update pool
                obj_game_manager.gold -= tower_cost;
                
                // Only decrement quantity if it's not infinite (-1)
                var current_quantity = tower_data[? "quantity"];
                if (current_quantity > 0) {
                    tower_data[? "quantity"] = current_quantity - 1;
                }
                
                // Apply cooldown
                tower_data[? "cooldown"] = tower_data[? "max_cooldown"];
                
                show_debug_message("Tower placed at grid [" + string(mouse_grid_x) + ", " + string(mouse_grid_y) + "]");
            } else {
                show_debug_message("Not enough gold!");
            }
        } else {
            show_debug_message("Cell already occupied!");
        }
    }
}

// Right-click to remove/recall tower (only if not dragging from pool)
// Removal behavior:
// - If a matching tower type exists in the tower pool, increment its quantity (if finite) or do nothing if infinite
// - Apply the pool cooldown for that tower type to prevent immediate re-summon
// - Refund a percentage of the tower cost to the player (sell-back)
// - Destroy the tower instance and free the grid cell
if (mouse_check_button_pressed(mb_right) && 
    (!instance_exists(obj_tower_pool) || !obj_tower_pool.is_dragging)) {
    var mouse_grid_x = floor((mouse_x - grid_start_x) / cell_size);
    var mouse_grid_y = floor((mouse_y - grid_start_y) / cell_size);
    
    if (mouse_grid_x >= 0 && mouse_grid_x < grid_cols && 
        mouse_grid_y >= 0 && mouse_grid_y < grid_rows) {
        
        if (ds_grid_get(grid, mouse_grid_x, mouse_grid_y) == 1) {
            // Get the tower instance
            var tower = ds_grid_get(tower_grid, mouse_grid_x, mouse_grid_y);
            if (instance_exists(tower)) {
                // Try to find a tower pool manager instance
                var pool_inst = noone;
                if (instance_exists(obj_tower_pool)) {
                    pool_inst = instance_find(obj_tower_pool, 0);
                }

                // Sell/recall refund percent (50%)
                var refund_percent = 0.5;
                var refund_amount = 0;

                // Determine tower cost from the instance (towers define 'tower_cost' in their Create event)
                if (variable_instance_exists(tower, "tower_cost")) {
                    refund_amount = floor(tower.tower_cost * refund_percent);
                }

                // If we have a pool manager, try to return the tower to the pool
                if (pool_inst != noone) {
                    var found_index = -1;
                    var pool_list = pool_inst.tower_pool;
                    for (var j = 0; j < ds_list_size(pool_list); j++) {
                        var td = pool_list[| j];
                        // Match by object (object index stored in pool entry)
                        if (td[? "object"] == tower.object_index) {
                            found_index = j;
                            break;
                        }
                    }

                    if (found_index >= 0) {
                        var td = pool_list[| found_index];
                        // If pool uses finite quantities (>=0), increment up to max
                        if (td[? "quantity"] >= 0) {
                            td[? "quantity"] = min(td[? "quantity"] + 1, td[? "max_quantity"]);
                        }
                        // Apply pool cooldown so the player cannot immediately re-place the same tower type
                        td[? "cooldown"] = td[? "max_cooldown"];
                    }
                }

                // Give player refund (even if no pool entry found)
                if (refund_amount > 0) {
                    obj_game_manager.gold += refund_amount;
                }

                // Destroy the tower instance
                instance_destroy(tower);
            }
            
            // Clear the cell
            ds_grid_set(grid, mouse_grid_x, mouse_grid_y, 0);
            ds_grid_set(tower_grid, mouse_grid_x, mouse_grid_y, noone);
            
            show_debug_message("Tower removed from grid [" + string(mouse_grid_x) + ", " + string(mouse_grid_y) + "] (partial refund applied)");
        }
    }
}
