/// @description Wave Management Logic

// Handle wave countdown
if (countdown_active) {
    wave_countdown--;
    
    if (wave_countdown <= 0) {
        start_wave();
    }
}

// Handle active wave
if (wave_active) {
    // Spawn enemies at intervals
    if (enemies_spawned < enemies_to_spawn) {
        spawn_timer++;
        
        if (spawn_timer >= spawn_interval) {
            spawn_enemy();
            spawn_timer = 0;
        }
    }
    
    // Check if wave is complete (all enemies spawned and defeated)
    if (enemies_spawned >= enemies_to_spawn && instance_number(obj_evil_gnome) == 0) {
        wave_complete = true;
        wave_active = false;
        
        // Update game manager and award wave completion bonus XP
        if (instance_exists(obj_game_manager)) {
            obj_game_manager.wave_in_progress = false;
            // Wave completion bonus: 30 XP + 15 per wave number (reduced for better pacing)
            var wave_bonus_xp = 30 + (wave_number * 15);
            obj_game_manager.gain_xp(wave_bonus_xp);
            show_debug_message("Wave " + string(wave_number) + " complete! Bonus XP: " + string(wave_bonus_xp));
        }
        
        // Start countdown for next wave
        wave_countdown = 180;
        countdown_active = true;
    }
}

// Function to spawn an enemy
function spawn_enemy() {
    var lane = irandom(grid_rows - 1);
    var enemy_y = grid_start_y + (lane * cell_size) + (cell_size / 2);
    var enemy = instance_create_depth(room_width - 50, enemy_y, -50, obj_evil_gnome);
    enemy.lane = lane;
    
    // Scale enemy stats with wave number
    enemy.hp += (wave_number - 1) * 5;
    enemy.max_hp = enemy.hp;
    enemy.gold_value += floor((wave_number - 1) * 2);
    
    enemies_spawned++;
}

// Function to start a wave
function start_wave() {
    wave_number++;
    wave_active = true;
    wave_complete = false;
    countdown_active = false;
    
    // Calculate enemies for this wave
    enemies_to_spawn = base_enemies + ((wave_number - 1) * enemies_per_wave_increase);
    enemies_spawned = 0;
    spawn_timer = 0;
    
    // Update game manager
    if (instance_exists(obj_game_manager)) {
        obj_game_manager.current_wave = wave_number;
        obj_game_manager.wave_in_progress = true;
    }
    
    show_debug_message("Wave " + string(wave_number) + " started! Enemies: " + string(enemies_to_spawn));
}
