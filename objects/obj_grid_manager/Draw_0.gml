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

// Highlight cell under mouse
var mouse_grid_x = floor((mouse_x - grid_start_x) / cell_size);
var mouse_grid_y = floor((mouse_y - grid_start_y) / cell_size);

if (mouse_grid_x >= 0 && mouse_grid_x < grid_cols && 
    mouse_grid_y >= 0 && mouse_grid_y < grid_rows) {
    var xx = grid_start_x + (mouse_grid_x * cell_size);
    var yy = grid_start_y + (mouse_grid_y * cell_size);
    
    draw_set_color(c_yellow);
    draw_set_alpha(0.3);
    draw_rectangle(xx, yy, xx + cell_size - 2, yy + cell_size - 2, false);
    draw_set_alpha(1.0);
}

draw_set_color(c_white);
