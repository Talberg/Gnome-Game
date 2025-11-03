/// @description Handle tower placement

// Toggle range display with R key
if (keyboard_check_pressed(ord("R"))) {
    global.show_ranges = !global.show_ranges;
}

// Check for mouse click
if (mouse_check_button_pressed(mb_left)) {
    // Convert mouse position to grid coordinates
    var mouse_grid_x = floor((mouse_x - grid_start_x) / cell_size);
    var mouse_grid_y = floor((mouse_y - grid_start_y) / cell_size);
    
    // Check if click is within grid bounds
    if (mouse_grid_x >= 0 && mouse_grid_x < grid_cols && 
        mouse_grid_y >= 0 && mouse_grid_y < grid_rows) {
        
        // Check if cell is empty
        if (ds_grid_get(grid, mouse_grid_x, mouse_grid_y) == 0) {
            // Calculate world position for the tower
            var tower_x = grid_start_x + (mouse_grid_x * cell_size) + (cell_size / 2);
            var tower_y = grid_start_y + (mouse_grid_y * cell_size) + (cell_size / 2);
            
            // Create the tower
            var tower = instance_create_depth(tower_x, tower_y, -100, obj_gnome_defender);
            tower.grid_x = mouse_grid_x;
            tower.grid_y = mouse_grid_y;
            
            // Mark cell as occupied
            ds_grid_set(grid, mouse_grid_x, mouse_grid_y, 1);
            ds_grid_set(tower_grid, mouse_grid_x, mouse_grid_y, tower);
            
            show_debug_message("Gnome defender placed at grid [" + string(mouse_grid_x) + ", " + string(mouse_grid_y) + "]");
        } else {
            show_debug_message("Cell already occupied!");
        }
    }
}

// Right-click to remove tower
if (mouse_check_button_pressed(mb_right)) {
    var mouse_grid_x = floor((mouse_x - grid_start_x) / cell_size);
    var mouse_grid_y = floor((mouse_y - grid_start_y) / cell_size);
    
    if (mouse_grid_x >= 0 && mouse_grid_x < grid_cols && 
        mouse_grid_y >= 0 && mouse_grid_y < grid_rows) {
        
        if (ds_grid_get(grid, mouse_grid_x, mouse_grid_y) == 1) {
            // Get the tower instance and destroy it
            var tower = ds_grid_get(tower_grid, mouse_grid_x, mouse_grid_y);
            if (instance_exists(tower)) {
                instance_destroy(tower);
            }
            
            // Clear the cell
            ds_grid_set(grid, mouse_grid_x, mouse_grid_y, 0);
            ds_grid_set(tower_grid, mouse_grid_x, mouse_grid_y, noone);
            
            show_debug_message("Gnome defender removed from grid [" + string(mouse_grid_x) + ", " + string(mouse_grid_y) + "]");
        }
    }
}
