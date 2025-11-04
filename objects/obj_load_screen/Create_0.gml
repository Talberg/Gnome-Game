/// @description Create the load/save screen UI with save slots

menu_x = 120;
menu_y = 80;
menu_width = room_width - 240;
menu_height = room_height - 160;
title = "Select Save or Start New Game";

// Scan for save files in saves/ folder
save_dir = "saves";
save_slots = [];

// Check for up to 3 save slots
for (var i = 0; i < 3; i++) {
    var slot_name = (i == 0) ? "default" : "slot" + string(i);
    var filename = save_dir + "/loadout_" + slot_name + ".json";
    
    var slot_data = { 
        slot_index: i, 
        slot_name: slot_name, 
        filename: filename,
        exists: false,
        turret: "Empty",
        gold: 0,
        timestamp: ""
    };
    
    if (file_exists(filename)) {
        // Read and parse the save file
        var fh = file_text_open_read(filename);
        var json_text = file_text_read_string(fh);
        file_text_close(fh);
        
        var data = json_decode(json_text);
        if (!is_undefined(data)) {
            slot_data.exists = true;
            // Extract turret name
            if (!is_undefined(data.turret_selection) && is_array(data.turret_selection) && array_length(data.turret_selection) > 0) {
                var turret_id = data.turret_selection[0];
                // Convert obj_tower_basic -> "Basic Gnome" etc
                if (string_pos("basic", turret_id) > 0) slot_data.turret = "Basic Gnome";
                else if (string_pos("sniper", turret_id) > 0) slot_data.turret = "Sniper Gnome";
                else if (string_pos("rapid", turret_id) > 0) slot_data.turret = "Rapid Gnome";
                else if (string_pos("bomb", turret_id) > 0) slot_data.turret = "Bomb Gnome";
                else slot_data.turret = turret_id;
            }
            // Extract gold
            if (!is_undefined(data.meta) && !is_undefined(data.meta.gold)) {
                slot_data.gold = data.meta.gold;
            }
            // Extract timestamp
            if (!is_undefined(data.meta) && !is_undefined(data.meta.generated)) {
                slot_data.timestamp = data.meta.generated;
            }
        }
    }
    
    array_push(save_slots, slot_data);
}

// Layout for slots
slot_card_w = 320;
slot_card_h = 120;
slot_gap = 24;
slot_start_x = menu_x + 40;
slot_start_y = menu_y + 100;

// New Game button
new_game_btn = { 
    x: menu_x + menu_width - 240, 
    y: menu_y + menu_height - 80, 
    w: 200, 
    h: 56, 
    label: "New Game" 
};

hover_slot = -1;
hover_new_game = false;
