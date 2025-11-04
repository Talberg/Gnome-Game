/// @description Handle save slot hover and clicks

var mx = mouse_x;
var my = mouse_y;

// Check slot hovers
hover_slot = -1;
for (var i = 0; i < array_length(save_slots); i++) {
    var sx = slot_start_x + i * (slot_card_w + slot_gap);
    var sy = slot_start_y;
    if (mx >= sx && mx <= sx + slot_card_w && my >= sy && my <= sy + slot_card_h) {
        hover_slot = i;
        break;
    }
}

// Check New Game button hover
var b = new_game_btn;
hover_new_game = (mx >= b.x && mx <= b.x + b.w && my >= b.y && my <= b.y + b.h);

// Handle slot clicks
if (hover_slot >= 0 && mouse_check_button_pressed(mb_left)) {
    var slot = save_slots[hover_slot];
    if (slot.exists) {
        // Load this save
        show_debug_message("Loading slot " + string(slot.slot_index + 1) + " (" + slot.slot_name + ")");
        // Update the load script to accept a slot name parameter temporarily
        global.current_save_slot = slot.slot_name;
        var ok = scr_load_loadout();
        if (ok) {
            show_debug_message("Loaded save from slot " + string(slot.slot_index + 1));
            // Go to gameplay room
            if (is_undefined(Room1) == false) {
                room_goto(Room1);
            } else {
                var r_go = asset_get_index("Room1");
                if (r_go != -1) room_goto(r_go); else room_goto(room_first);
            }
        }
    } else {
        // Empty slot - treat as New Game for this slot
        show_debug_message("Empty slot clicked - starting new game in slot " + string(slot.slot_index + 1));
        global.current_save_slot = slot.slot_name;
        if (asset_get_index("scr_new_game") != -1) {
            scr_new_game();
        }
        var rt = asset_get_index("Room_TurretSelect");
        if (rt != -1) room_goto(rt); else {
            var rn = asset_get_index("Room1");
            if (rn != -1) room_goto(rn); else room_goto(room_first);
        }
    }
}

// Handle New Game button click
if (hover_new_game && mouse_check_button_pressed(mb_left)) {
    show_debug_message("New Game button clicked");
    // Find first empty slot or use default
    var target_slot = "default";
    for (var i = 0; i < array_length(save_slots); i++) {
        if (!save_slots[i].exists) {
            target_slot = save_slots[i].slot_name;
            break;
        }
    }
    global.current_save_slot = target_slot;
    if (asset_get_index("scr_new_game") != -1) {
        scr_new_game();
    }
    var rt = asset_get_index("Room_TurretSelect");
    if (rt != -1) room_goto(rt); else {
        var rn = asset_get_index("Room1");
        if (rn != -1) room_goto(rn); else room_goto(room_first);
    }
}
