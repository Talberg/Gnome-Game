/// @description Draw the load/save UI panel

// Dim background
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(0,0,room_width,room_height,false);
draw_set_alpha(1);

// Panel
draw_set_color(c_dkgray);
draw_rectangle(menu_x, menu_y, menu_x+menu_width, menu_y+menu_height, false);

// Border
draw_set_color(c_white);
draw_rectangle(menu_x, menu_y, menu_x+menu_width, menu_y+menu_height, true);

// Title
draw_set_color(c_lime);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
if (variable_global_exists("font_default")) draw_set_font(font_default);
draw_text(menu_x + menu_width/2, menu_y + 12, title);

// Subtitle
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(menu_x + menu_width/2, menu_y + 42, subtitle);

// Buttons
for (var i = 0; i < array_length(buttons); i++) {
    var b = buttons[i];
    var is_hover = (i == hover_button);
    draw_set_color(is_hover ? c_yellow : c_black);
    draw_rectangle(b.x, b.y, b.x + b.w, b.y + b.h, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(b.x + b.w/2, b.y + b.h/2, b.label);
}

// Reset
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
