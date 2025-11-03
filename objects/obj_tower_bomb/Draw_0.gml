/// @description Draw the bomb gnome tower

// Use placeholder drawing function with red color
draw_gnome_placeholder(sprite_index, x, y, false, tower_color);

// Draw range circle when selected or debugging
if (global.show_ranges) {
    draw_set_color(tower_color);
    draw_set_alpha(0.2);
    draw_circle(x, y, attack_range, false);
    draw_set_alpha(1.0);
    
    // Also draw AOE radius
    if (instance_exists(target)) {
        draw_set_color(c_orange);
        draw_set_alpha(0.3);
        draw_circle(target.x, target.y, aoe_radius, false);
        draw_set_alpha(1.0);
    }
    
    draw_set_color(c_white);
}
