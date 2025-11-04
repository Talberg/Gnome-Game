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

// Draw level
draw_set_color(c_aqua);
draw_text(520, 10, "Level: " + string(player_level));

// Draw XP bar
var xp_bar_x = 660;
var xp_bar_y = 12;
var xp_bar_w = 200;
var xp_bar_h = 16;
var xp_progress = (xp_to_next_level > 0) ? (player_xp / xp_to_next_level) : 1;

// XP bar background
draw_set_color(c_dkgray);
draw_rectangle(xp_bar_x, xp_bar_y, xp_bar_x + xp_bar_w, xp_bar_y + xp_bar_h, false);

// XP bar fill
draw_set_color(c_lime);
draw_rectangle(xp_bar_x, xp_bar_y, xp_bar_x + (xp_bar_w * xp_progress), xp_bar_y + xp_bar_h, false);

// XP bar border
draw_set_color(c_white);
draw_rectangle(xp_bar_x, xp_bar_y, xp_bar_x + xp_bar_w, xp_bar_y + xp_bar_h, true);

// XP text
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (player_level < max_level) {
    draw_text(xp_bar_x + xp_bar_w/2, xp_bar_y + xp_bar_h/2, string(player_xp) + "/" + string(xp_to_next_level));
} else {
    draw_text(xp_bar_x + xp_bar_w/2, xp_bar_y + xp_bar_h/2, "MAX LEVEL");
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);

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
