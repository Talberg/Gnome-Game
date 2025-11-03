/// @description Grid Manager Initialization

// Grid configuration
grid_rows = 5;
grid_cols = 10;
cell_size = 64;

// Grid positioning (centered in room)
grid_start_x = (room_width - (grid_cols * cell_size)) / 2;
grid_start_y = (room_height - (grid_rows * cell_size)) / 2;

// Create 2D array to track what's in each grid cell
// 0 = empty, 1 = occupied
grid = ds_grid_create(grid_cols, grid_rows);
ds_grid_clear(grid, 0);

// Array to store tower/unit instances in each cell
tower_grid = ds_grid_create(grid_cols, grid_rows);
ds_grid_clear(tower_grid, noone);

// Global settings
global.show_ranges = false; // Press 'R' to toggle range display
