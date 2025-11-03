/// @description Draw evil gnome

// Use placeholder drawing function
draw_gnome_placeholder(sprite_index, x, y, true); // true = evil (red)

// Draw health bar above gnome
var bar_width = 40;
var bar_height = 4;
var bar_x = x - (bar_width / 2);
var bar_y = y - 35;

// Background (black)
draw_set_color(c_black);
draw_rectangle(bar_x - 1, bar_y - 1, bar_x + bar_width + 1, bar_y + bar_height + 1, false);

// Health (red to green gradient)
var health_percent = hp / max_hp;
var health_color = merge_color(c_red, c_lime, health_percent);
draw_set_color(health_color);
draw_rectangle(bar_x, bar_y, bar_x + (bar_width * health_percent), bar_y + bar_height, false);

// Border (white)
draw_set_color(c_white);
draw_rectangle(bar_x - 1, bar_y - 1, bar_x + bar_width + 1, bar_y + bar_height + 1, true);

draw_set_color(c_white); // Reset
