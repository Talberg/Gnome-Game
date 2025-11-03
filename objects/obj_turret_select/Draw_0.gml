/// @description Draw turret selection UI

// Dim background
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(0,0,room_width,room_height,false);
draw_set_alpha(1);

// Panel
draw_set_color(c_dkgray);
draw_rectangle(menu_x, menu_y, menu_x+menu_w, menu_y+menu_h, false);
draw_set_color(c_white);
draw_rectangle(menu_x, menu_y, menu_x+menu_w, menu_y+menu_h, true);

// Title
draw_set_color(c_lime);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
if (variable_global_exists("font_default")) draw_set_font(font_default);
draw_text(menu_x + menu_w/2, menu_y + 8, title);
draw_set_color(c_white);
draw_text(menu_x + menu_w/2, menu_y + 34, subtitle);

// Draw turret cards
var cols = array_length(turret_types);
var card_w = 220; var card_h = 120; var gap = 24;
var start_x = menu_x + 40; var start_y = menu_y + 80;
for (var i = 0; i < cols; i++) {
    var cx = start_x + i * (card_w + gap);
    var cy = start_y;
    var is_hover = (i == hover_index);
    var is_sel = selected[i];
    draw_set_color(is_sel ? c_lime : (is_hover ? c_yellow : c_white));
    draw_rectangle(cx, cy, cx + card_w, cy + card_h, false);
    draw_set_color(c_black);
    draw_text(cx + card_w/2, cy + 16, turret_types[i].label);
    draw_set_color(c_white);
    // small description placeholder
    draw_text(cx + 8, cy + 44, "A useful gnome turret.");
}

// Draw Start button
draw_set_color(c_black);
draw_rectangle(btn_start.x, btn_start.y, btn_start.x + btn_start.w, btn_start.y + btn_start.h, false);
draw_set_color(c_white);
draw_set_halign(fa_center); draw_set_valign(fa_middle);
draw_text(btn_start.x + btn_start.w/2, btn_start.y + btn_start.h/2, btn_start.label);

// Reset
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
