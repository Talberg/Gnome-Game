/// @description Draw placeholder gnome graphics
/// @param sprite_index The sprite to draw for
/// @param x X position
/// @param y Y position
/// @param is_evil Whether this is an evil gnome (red) or defender (blue)

function draw_gnome_placeholder(_sprite, _x, _y, _is_evil) {
    // Draw body (circle)
    var body_color = _is_evil ? c_red : c_blue;
    draw_set_color(body_color);
    draw_circle(_x, _y, 16, false);
    
    // Draw hat (triangle)
    var hat_color = _is_evil ? c_maroon : c_navy;
    draw_set_color(hat_color);
    draw_triangle(
        _x - 12, _y - 10,
        _x + 12, _y - 10,
        _x, _y - 30,
        false
    );
    
    // Draw eyes (white circles)
    draw_set_color(c_white);
    draw_circle(_x - 6, _y - 4, 3, false);
    draw_circle(_x + 6, _y - 4, 3, false);
    
    // Draw pupils (black dots)
    draw_set_color(c_black);
    draw_circle(_x - 6, _y - 4, 1, false);
    draw_circle(_x + 6, _y - 4, 1, false);
    
    // Draw beard (white semi-circle)
    draw_set_color(c_white);
    draw_circle(_x, _y + 8, 8, false);
    
    // Draw outline
    draw_set_color(c_black);
    draw_circle(_x, _y, 16, true);
    
    draw_set_color(c_white); // Reset color
}

function draw_projectile_placeholder(_x, _y) {
    // Draw a yellow star/spark
    draw_set_color(c_yellow);
    draw_circle(_x, _y, 6, false);
    
    draw_set_color(c_white);
    draw_circle(_x, _y, 3, false);
    
    draw_set_color(c_black);
    draw_circle(_x, _y, 6, true);
    
    draw_set_color(c_white); // Reset color
}
