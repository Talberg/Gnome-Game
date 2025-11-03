/// @description Draw UI

// Draw background for UI
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, room_width, 40, false);
draw_set_alpha(1.0);

// Draw gold
draw_set_color(c_yellow);
draw_text(20, 10, "Gold: " + string(gold));

// Draw lives
draw_set_color(c_red);
draw_text(200, 10, "Lives: " + string(lives));

// Draw wave info
draw_set_color(c_white);
draw_text(380, 10, "Wave: " + string(current_wave));

// Draw hint
draw_set_color(c_ltgray);
draw_text(560, 10, "[R] Toggle Ranges");

// Game over message
if (game_over) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_red);
    draw_text_transformed(room_width / 2, room_height / 2, "GAME OVER", 3, 3, 0);
    draw_set_color(c_white);
    draw_text(room_width / 2, room_height / 2 + 60, "Press R to restart");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Victory message
if (game_won) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_lime);
    draw_text_transformed(room_width / 2, room_height / 2, "VICTORY!", 3, 3, 0);
    draw_set_color(c_white);
    draw_text_transformed(room_width / 2, room_height / 2 + 60, "You survived all 10 waves!", 1.5, 1.5, 0);
    draw_text(room_width / 2, room_height / 2 + 100, "Press R to play again");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

draw_set_color(c_white); // Reset
