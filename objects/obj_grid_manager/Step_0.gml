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

// Right-click to remove tower (only if not dragging from pool)
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
                // Return tower to pool (we'll implement this later)
                // For now, just destroy it
                instance_destroy(tower);
            }
            
            // Clear the cell
            ds_grid_set(grid, mouse_grid_x, mouse_grid_y, 0);
            ds_grid_set(tower_grid, mouse_grid_x, mouse_grid_y, noone);
            
            show_debug_message("Tower removed from grid [" + string(mouse_grid_x) + ", " + string(mouse_grid_y) + "]");
        }
    }
}
