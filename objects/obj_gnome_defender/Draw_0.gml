/// @description Draw the gnome defender

// Use placeholder drawing function
draw_gnome_placeholder(sprite_index, x, y, false);

// Draw range circle when selected or debugging
if (global.show_ranges) {
    draw_set_color(c_blue);
    draw_set_alpha(0.2);
    draw_circle(x, y, attack_range, false);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}
