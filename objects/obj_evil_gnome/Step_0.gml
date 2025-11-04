/// @description Move left across the screen

// Move left
x -= move_speed;

// Check if reached the left edge (game over territory)
if (x < 0) {
    // Enemy got through - damage the player
    if (instance_exists(obj_game_manager)) {
        obj_game_manager.lives -= 1;
    }
    instance_destroy();
}

// Die if health reaches 0
if (hp <= 0) {
    // Give player gold and XP
    if (instance_exists(obj_game_manager)) {
        obj_game_manager.gold += gold_value;
        // Award XP: 8 base XP + 3 per wave (reduced for better balance)
        var xp_award = 8 + (obj_game_manager.current_wave * 3);
        obj_game_manager.gain_xp(xp_award);
    }
    instance_destroy();
}
