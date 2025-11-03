/// @description Update tower pool cooldowns and mouse interaction

// Update cooldowns
for (var i = 0; i < ds_list_size(tower_pool); i++) {
    var tower_data = tower_pool[| i];
    var cooldown = tower_data[? "cooldown"];
    
    if (cooldown > 0) {
        tower_data[? "cooldown"] = cooldown - 1;
    }
}

// Check mouse position over cards
var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

hovering_card = -1;

// Check if mouse is over the panel area
if (mouse_gui_y >= panel_y) {
    // Check each card
    for (var i = 0; i < ds_list_size(tower_pool); i++) {
        var card_x = card_start_x + i * (card_width + card_padding);
        var card_y = panel_y + 10;
        
        if (mouse_gui_x >= card_x && mouse_gui_x <= card_x + card_width &&
            mouse_gui_y >= card_y && mouse_gui_y <= card_y + card_height) {
            hovering_card = i;
            break;
        }
    }
}

// Handle clicking on cards
if (hovering_card >= 0 && mouse_check_button_pressed(mb_left)) {
    var tower_data = tower_pool[| hovering_card];
    var quantity = tower_data[? "quantity"];
    var cooldown = tower_data[? "cooldown"];
    var cost = tower_data[? "cost"];
    
    // Check if tower is available
    // quantity < 0 means infinite uses
    var has_quantity = (quantity < 0 || quantity > 0);
    if (has_quantity && cooldown <= 0 && obj_game_manager.gold >= cost) {
        selected_tower_index = hovering_card;
        is_dragging = true;
        drag_tower_object = tower_data[? "object"];
        drag_start_x = mouse_gui_x;
        drag_start_y = mouse_gui_y;
    }
}

// Handle Save/Load button clicks (GUI coords)
var btn_w = 80; var btn_h = 28; var btn_gap = 8;
var btn_x = room_width - 10 - btn_w;
var btn_y = panel_y + 12;
var load_y = btn_y + btn_h + btn_gap;

// Save
if (mouse_gui_y >= btn_y && mouse_gui_y <= btn_y + btn_h && mouse_gui_x >= btn_x && mouse_gui_x <= btn_x + btn_w) {
    if (mouse_check_button_pressed(mb_left)) {
        var fname = scr_save_loadout("default");
        if (is_string(fname)) show_debug_message("Saved loadout: " + fname);
    }
}

// Load
if (mouse_gui_y >= load_y && mouse_gui_y <= load_y + btn_h && mouse_gui_x >= btn_x && mouse_gui_x <= btn_x + btn_w) {
    if (mouse_check_button_pressed(mb_left)) {
        var ok = scr_load_loadout("default");
        if (ok) show_debug_message("Loaded default loadout");
    }
}

// Handle releasing drag
if (is_dragging && mouse_check_button_released(mb_left)) {
    // The grid manager will handle the actual placement
    // We just reset our drag state here
    is_dragging = false;
    selected_tower_index = -1;
}

// Cancel drag with right click
if (is_dragging && mouse_check_button_pressed(mb_right)) {
    is_dragging = false;
    selected_tower_index = -1;
    drag_tower_object = noone;
}
