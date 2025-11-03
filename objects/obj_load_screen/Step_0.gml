/// @description Handle button hover and clicks on the load screen

// Use room coordinates for these buttons (they're drawn in room space)
var mx = mouse_x;
var my = mouse_y;

hover_button = -1;
for (var i = 0; i < array_length(buttons); i++) {
    var b = buttons[i];
    if (mx >= b.x && mx <= b.x + b.w && my >= b.y && my <= b.y + b.h) {
        hover_button = i;
        break;
    }
}

if (hover_button >= 0 && mouse_check_button_pressed(mb_left)) {
    var act = buttons[hover_button].action;
    if (act == "load") {
        var ok = scr_load_loadout();
        if (ok) {
            show_debug_message("Loaded default loadout");
            // After loading, go to the main gameplay room
            var r_go = asset_get_index("Room1");
            if (r_go != -1) room_goto(r_go); else room_goto(room_first);
        }
    } else if (act == "new") {
        // Start a fresh game: run the new-game initializer then go to the turret selection room
        show_debug_message("Start->New Game clicked");
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

// Allow Escape to go back
if (keyboard_check_pressed(vk_escape)) {
    if (is_undefined(Room1) == false) room_goto(Room1);
}
