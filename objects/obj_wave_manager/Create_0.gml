/// @description Wave Manager Initialization

// Wave configuration
wave_number = 0;
wave_active = false;
wave_complete = false;

// Spawn timing
spawn_timer = 0;
spawn_interval = 90; // frames between enemy spawns (1.5 seconds at 60fps)
enemies_to_spawn = 0;
enemies_spawned = 0;

// Wave difficulty scaling
base_enemies = 5;
enemies_per_wave_increase = 3;

// Countdown between waves
wave_countdown = 180; // 3 seconds at 60fps
countdown_active = false;

// Get grid info from grid manager
if (instance_exists(obj_grid_manager)) {
    grid_start_y = obj_grid_manager.grid_start_y;
    cell_size = obj_grid_manager.cell_size;
    grid_rows = obj_grid_manager.grid_rows;
} else {
    // Fallback values
    grid_start_y = 100;
    cell_size = 64;
    grid_rows = 5;
}

// Auto-start first wave after a delay
alarm[0] = 120; // Start first wave after 2 seconds
