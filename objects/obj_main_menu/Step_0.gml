/// @description Main menu interaction

// Track hover
hover_button = -1;
for (var i = 0; i < array_length(buttons); i++) {
    var b = buttons[i];
    if (mouse_x >= b.x && mouse_x <= b.x + b.w && mouse_y >= b.y && mouse_y <= b.y + b.h) {
        hover_button = i; break;
    }
}

// Click handling
if (mouse_check_button_pressed(mb_left)) {
    if (hover_button >= 0) {
        var sel = buttons[hover_button];
        switch (sel.id) {
            case "start":
                // Go to main room (Room1) if available
                var r = asset_get_index("Room1");
                if (r != -1) room_goto(r); else room_goto(room_first);
                break;
            case "loadout":
                // Open the dedicated Loadout room if available
                var r2 = asset_get_index("Room_Load");
                if (r2 != -1) room_goto(r2); else {
                    // Fallback to Room1
                    var rfb = asset_get_index("Room1");
                    if (rfb != -1) room_goto(rfb); else room_goto(room_first);
                }
                break;
            case "options":
                global.show_ranges = !global.show_ranges;
                break;
            case "quit":
                game_end();
                break;
        }
    }
}

// Close menu with Escape
if (keyboard_check_pressed(vk_escape)) {
    // if we're in a room already, go to it; otherwise close the game
}
