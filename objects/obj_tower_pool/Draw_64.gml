/// @description Draw tower pool UI panel

// Draw panel background
draw_set_color(c_dkgray);
draw_set_alpha(0.9);
draw_rectangle(0, panel_y, room_width, room_height, false);
draw_set_alpha(1.0);

// Draw panel border
draw_set_color(c_black);
draw_rectangle(0, panel_y, room_width, room_height, true);

// Draw title
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(10, panel_y + 5, "Tower Pool:");

// Draw each tower card
for (var i = 0; i < ds_list_size(tower_pool); i++) {
    var tower_data = tower_pool[| i];
    var card_x = card_start_x + i * (card_width + card_padding);
    var card_y = panel_y + 10;
    
    var tower_name = tower_data[? "name"];
    var tower_color = tower_data[? "color"];
    var quantity = tower_data[? "quantity"];
    var max_quantity = tower_data[? "max_quantity"];
    var cooldown = tower_data[? "cooldown"];
    var max_cooldown = tower_data[? "max_cooldown"];
    var cost = tower_data[? "cost"];
    
    // Determine card state
    // quantity < 0 means infinite uses
    var has_quantity = (quantity < 0 || quantity > 0);
    var is_available = (has_quantity && cooldown <= 0 && obj_game_manager.gold >= cost);
    var is_selected = (i == selected_tower_index);
    var is_hovering = (i == hovering_card);
    
    // Draw card background
    if (is_selected) {
        draw_set_color(c_yellow);
        draw_set_alpha(0.8);
    } else if (is_hovering && is_available) {
        draw_set_color(c_white);
        draw_set_alpha(0.6);
    } else if (!is_available) {
        draw_set_color(c_gray);
        draw_set_alpha(0.5);
    } else {
        draw_set_color(tower_color);
        draw_set_alpha(0.7);
    }
    draw_rectangle(card_x, card_y, card_x + card_width, card_y + card_height, false);
    draw_set_alpha(1.0);
    
    // Draw card border
    draw_set_color(is_selected ? c_yellow : (is_hovering ? c_white : c_black));
    draw_rectangle(card_x, card_y, card_x + card_width, card_y + card_height, true);
    
    // Draw tower preview (small gnome)
    var center_x = card_x + card_width / 2;
    var preview_y = card_y + 25;
    
    draw_set_alpha(is_available ? 1.0 : 0.5);
    draw_gnome_placeholder(spr_gnome_defender, center_x, preview_y, false, tower_color);
    draw_set_alpha(1.0);
    
    // Draw tower name
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(center_x, card_y + 45, tower_name);
    
    // Draw quantity (show infinity symbol for unlimited towers)
    if (quantity < 0) {
        draw_set_color(c_lime);
        draw_text(center_x, card_y + 60, "∞ UNLIMITED");
    } else {
        var qty_color = (quantity > 0) ? c_white : c_red;
        draw_set_color(qty_color);
        draw_text(center_x, card_y + 60, "x" + string(quantity) + "/" + string(max_quantity));
    }
    
    // Draw cooldown bar if on cooldown
    if (cooldown > 0) {
        var bar_width = card_width - 10;
        var bar_height = 8;
        var bar_x = card_x + 5;
        var bar_y = card_y + card_height - bar_height - 5;
        
        // Background
        draw_set_color(c_black);
        draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);
        
        // Fill
        var fill_width = (cooldown / max_cooldown) * bar_width;
        draw_set_color(c_orange);
        draw_rectangle(bar_x, bar_y, bar_x + fill_width, bar_y + bar_height, false);
        
        // Border
        draw_set_color(c_white);
        draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, true);
        
        // Cooldown text
        draw_set_halign(fa_center);
        var cd_seconds = ceil(cooldown / 60);
        draw_text(center_x, bar_y - 12, string(cd_seconds) + "s");
    } else if (cost > 0) {
        // Draw cost if there is one
        var cost_color = (obj_game_manager.gold >= cost) ? c_lime : c_red;
        draw_set_color(cost_color);
        draw_set_halign(fa_center);
        draw_text(center_x, card_y + 75, string(cost) + "g");
    }
}

// Draw dragging preview
if (is_dragging) {
    var mouse_gui_x = device_mouse_x_to_gui(0);
    var mouse_gui_y = device_mouse_y_to_gui(0);
    
    // Convert GUI coordinates to room coordinates for preview
    var room_mouse_x = mouse_x;
    var room_mouse_y = mouse_y;
    
    // Draw preview at mouse position
    var tower_data = tower_pool[| selected_tower_index];
    var tower_color = tower_data[? "color"];
    
    draw_set_alpha(0.7);
    draw_gnome_placeholder(spr_gnome_defender, room_mouse_x, room_mouse_y, false, tower_color);
    draw_set_alpha(1.0);
    
    // Draw instruction text
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(10, 10, "Drag to grid to place tower (Right-click to cancel)");
}

// Reset draw settings
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1.0);

// Draw Save/Load buttons on the right side of the panel
var btn_w = 80; var btn_h = 28; var btn_gap = 8;
var btn_x = room_width - 10 - btn_w;
var btn_y = panel_y + 12;

// Save button
draw_set_color(c_black);
draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
draw_set_color(c_white);
draw_set_halign(fa_center); draw_set_valign(fa_middle);
draw_text(btn_x + btn_w/2, btn_y + btn_h/2, "Save");

// Load button (below save)
var load_y = btn_y + btn_h + btn_gap;
draw_set_color(c_black);
draw_rectangle(btn_x, load_y, btn_x + btn_w, load_y + btn_h, false);
draw_set_color(c_white);
draw_text(btn_x + btn_w/2, load_y + btn_h/2, "Load");

// Reset alignment
draw_set_halign(fa_left); draw_set_valign(fa_top);
