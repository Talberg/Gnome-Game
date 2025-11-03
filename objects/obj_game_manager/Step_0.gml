/// @description Check game over conditions

// Check if player lost all lives
if (lives <= 0 && !game_over) {
    game_over = true;
    show_debug_message("GAME OVER - All lives lost!");
}

// Check for win condition (survived 10 waves)
if (current_wave >= 10 && !wave_in_progress && instance_number(obj_evil_gnome) == 0 && !game_won) {
    game_won = true;
    show_debug_message("VICTORY - All waves completed!");
}

// Press R to restart when game over
if ((game_over || game_won) && keyboard_check_pressed(ord("R"))) {
    room_restart();
}

// Save/Load loadout shortcuts
// Press S to save the current tower pool to loadout_default.json
if (keyboard_check_pressed(ord("S"))) {
    var fname = scr_save_loadout();
    show_debug_message("Saved loadout: " + string(fname));
}

// Press L to load the default loadout
if (keyboard_check_pressed(ord("L"))) {
    var ok = scr_load_loadout();
    if (ok) show_debug_message("Loaded default loadout");
}
