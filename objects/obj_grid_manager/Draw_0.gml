/// @description Draw the grid

// Draw grid cells
for (var row = 0; row < grid_rows; row++) {
    for (var col = 0; col < grid_cols; col++) {
        var xx = grid_start_x + (col * cell_size);
        var yy = grid_start_y + (row * cell_size);
        
        // Check if cell is occupied
        var is_occupied = ds_grid_get(grid, col, row);
        
        // Draw cell background
        if (is_occupied) {
            draw_set_color(c_gray);
        } else {
            draw_set_color(c_dkgray);
        }
        draw_rectangle(xx, yy, xx + cell_size - 2, yy + cell_size - 2, false);
        
        // Draw cell border
        draw_set_color(c_white);
        draw_rectangle(xx, yy, xx + cell_size - 2, yy + cell_size - 2, true);
    }
}

// Highlight cell under mouse (with validation when dragging)
var mouse_grid_x = floor((mouse_x - grid_start_x) / cell_size);
var mouse_grid_y = floor((mouse_y - grid_start_y) / cell_size);

if (mouse_grid_x >= 0 && mouse_grid_x < grid_cols && 
    mouse_grid_y >= 0 && mouse_grid_y < grid_rows) {
    var xx = grid_start_x + (mouse_grid_x * cell_size);
    var yy = grid_start_y + (mouse_grid_y * cell_size);
    
    // Check if we're dragging a tower from the pool
    var is_dragging = instance_exists(obj_tower_pool) && obj_tower_pool.is_dragging;
    var is_occupied = ds_grid_get(grid, mouse_grid_x, mouse_grid_y);
    
    if (is_dragging) {
        // Show green for valid placement, red for invalid
        if (!is_occupied) {
            draw_set_color(c_lime);
            draw_set_alpha(0.5);
        } else {
            draw_set_color(c_red);
            draw_set_alpha(0.5);
        }
        draw_rectangle(xx, yy, xx + cell_size - 2, yy + cell_size - 2, false);
        draw_set_alpha(1.0);
        
        // Draw X for invalid placement
        if (is_occupied) {
            draw_set_color(c_red);
            draw_line_width(xx + 5, yy + 5, xx + cell_size - 7, yy + cell_size - 7, 3);
            draw_line_width(xx + cell_size - 7, yy + 5, xx + 5, yy + cell_size - 7, 3);
        }
    } else {
        // Normal hover highlight
        draw_set_color(c_yellow);
        draw_set_alpha(0.3);
        draw_rectangle(xx, yy, xx + cell_size - 2, yy + cell_size - 2, false);
        draw_set_alpha(1.0);
    }
}

draw_set_color(c_white);
