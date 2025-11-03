/// @description Draw the tower menu (sell/upgrade)

// Panel background
draw_set_color(panel_color);
draw_rectangle(x, y, x + menu_width, y + menu_height, false);

// Border
draw_set_color(border_color);
draw_rectangle(x, y, x + menu_width, y + menu_height, true);

// Draw buttons
var sell_x = x + button_padding;
var sell_y = y + button_padding;
var upgrade_x = x + button_padding * 2 + btn_w;
var upgrade_y = sell_y;

// Sell button
draw_set_color(hover_sell ? c_red : c_maroon);
draw_rectangle(sell_x, sell_y, sell_x + btn_w, sell_y + btn_h, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(sell_x + btn_w/2, sell_y + btn_h/2, "Sell");

// Upgrade button
var can_upgrade = (upgrade_level < max_upgrade_level && instance_exists(target_tower));
draw_set_color(hover_upgrade && can_upgrade ? c_lime : c_gray);
draw_rectangle(upgrade_x, upgrade_y, upgrade_x + btn_w, upgrade_y + btn_h, false);

draw_set_color(c_white);
var upgrade_label = "Upgrade";
if (instance_exists(target_tower) && variable_instance_exists(target_tower, "tower_cost")) {
    var base_cost = target_tower.tower_cost;
    var cur_level = variable_instance_exists(target_tower, "upgrade_level") ? target_tower.upgrade_level : 0;
    var next_cost = ceil(base_cost * 0.75 * (cur_level + 1));
    upgrade_label = upgrade_label + " (" + string(next_cost) + "g)";
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(upgrade_x + btn_w/2, upgrade_y + btn_h/2, upgrade_label);

// Reset draw settings
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
