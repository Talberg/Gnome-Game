/// @description Draw the rapid fire gnome tower

// Use placeholder drawing function with orange color
draw_gnome_placeholder(sprite_index, x, y, false, tower_color);

// Draw range circle when selected or debugging
if (global.show_ranges) {
    draw_set_color(tower_color);
    draw_set_alpha(0.2);
    draw_circle(x, y, attack_range, false);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}

// Show muzzle flash when firing
if (attack_timer > attack_cooldown - 5 && instance_exists(target)) {
    draw_set_color(c_yellow);
    draw_set_alpha(0.7);
    draw_circle(x, y, 20, false);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}
