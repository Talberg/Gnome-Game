/// @description Draw wave information

// Draw wave status
if (countdown_active) {
    var seconds_left = ceil(wave_countdown / 60);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_yellow);
    draw_text_transformed(room_width / 2, room_height / 2 - 100, 
        "Next wave in " + string(seconds_left) + "...", 2, 2, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

// Draw wave progress
if (wave_active) {
    var progress_text = "Wave " + string(wave_number) + ": " + 
        string(enemies_spawned) + "/" + string(enemies_to_spawn) + " spawned | " +
        string(instance_number(obj_evil_gnome)) + " remaining";
    
    draw_set_color(c_white);
    draw_text(room_width / 2 - 150, 50, progress_text);
}
