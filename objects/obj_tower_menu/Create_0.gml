/// @description Tower menu initialization

// The grid manager will set `target_tower` after creating this instance
if (!variable_instance_exists(id, "target_tower")) {
    target_tower = noone;
}

menu_width = 140;
menu_height = 64;

// Button rectangles (relative to menu origin at x,y)
button_padding = 8;
btn_w = (menu_width - button_padding * 3) / 2;
btn_h = menu_height - button_padding * 2;

// local state
hover_sell = false;
hover_upgrade = false;

// Upgrade settings
upgrade_level = 0;
max_upgrade_level = 3;
upgrade_multiplier = 1.5; // damage multiplier per upgrade

// Visual
panel_color = c_dkgray;
border_color = c_white;

// Debug: announce creation so we can confirm in GameMaker output
show_debug_message("obj_tower_menu created (id=" + string(id) + ") target_tower=" + string(target_tower) + " depth=" + string(depth));