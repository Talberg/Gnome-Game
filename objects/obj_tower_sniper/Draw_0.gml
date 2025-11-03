/// @description Draw the sniper gnome tower

// Use placeholder drawing function with blue color
draw_gnome_placeholder(sprite_index, x, y, false, tower_color);

// Draw range circle when selected or debugging
if (global.show_ranges) {
    draw_set_color(tower_color);
    draw_set_alpha(0.2);
    draw_circle(x, y, attack_range, false);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}

// Draw crosshair if we have a target
if (instance_exists(target)) {
    draw_set_color(c_red);
    draw_set_alpha(0.5);
    draw_line(target.x - 10, target.y, target.x + 10, target.y);
    draw_line(target.x, target.y - 10, target.x, target.y + 10);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}
