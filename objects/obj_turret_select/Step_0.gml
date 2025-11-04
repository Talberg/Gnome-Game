/// @description Handle input for turret selection screen

var mx = mouse_x;
var my = mouse_y;

// Calculate card positions
var cols = array_length(turret_types);
var card_w = 220;
var card_h = 120;
var gap = 24;
var start_x = menu_x + 40;
var start_y = menu_y + 80;

hover_index = -1;
for (var i = 0; i < cols; i++) {
    var cx = start_x + i * (card_w + gap);
    var cy = start_y;
    if (mx >= cx && mx <= cx + card_w && my >= cy && my <= cy + card_h) {
        hover_index = i;
        break;
    }
}

// Toggle selection on click
if (hover_index >= 0 && mouse_check_button_pressed(mb_left)) {
    // Enforce single-selection: deselect others and select this one. If already selected, deselect it.
    if (!selected[hover_index]) {
        // deselect all first
        for (var d = 0; d < array_length(selected); d++) selected[d] = false;
        // select the clicked card
        selected[hover_index] = true;
    } else {
        // clicking the already selected card will deselect it
        selected[hover_index] = false;
    }
}

// Start button click
if (mx >= btn_start.x && mx <= btn_start.x + btn_start.w && my >= btn_start.y && my <= btn_start.y + btn_start.h) {
    if (mouse_check_button_pressed(mb_left)) {
        // Build selected list of ids
        var chosen = [];
        for (var k = 0; k < array_length(turret_types); k++) {
            if (selected[k]) array_push(chosen, turret_types[k].id);
        }
        // store into a global so Room1 can read it
        global.turret_selection = chosen;
        show_debug_message("Turret selection saved: " + string(array_length(chosen)) + " items");
        // go to gameplay - prefer the room constant if it's available, otherwise fall back to asset lookup
        if (is_undefined(Room1) == false) {
            show_debug_message("Navigating to Room1 (resource constant)");
            room_goto(Room1);
        } else {
            var r = asset_get_index("Room1");
            show_debug_message("Room1 asset index = " + string(r));
            if (r != -1) room_goto(r); else room_goto(room_first);
        }
    }
}
