/// @description Draw damage number

// Set font and alignment
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw with outline for visibility
var draw_x = x;
var draw_y = y + y_offset;

// Black outline
draw_set_alpha(alpha * 0.7);
draw_set_color(c_black);
draw_text(draw_x - 1, draw_y - 1, damage_text);
draw_text(draw_x + 1, draw_y - 1, damage_text);
draw_text(draw_x - 1, draw_y + 1, damage_text);
draw_text(draw_x + 1, draw_y + 1, damage_text);

// Main text (yellow-orange for damage)
draw_set_alpha(alpha);
draw_set_color(c_orange);
draw_text(draw_x, draw_y, damage_text);

// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
