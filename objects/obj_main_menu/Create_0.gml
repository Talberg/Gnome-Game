/// @description Main menu initialization

// Layout for a simple main menu
menu_width = 420;
menu_height = 300;
menu_x = (room_width - menu_width) / 2;
menu_y = (room_height - menu_height) / 2;

button_w = 220;
button_h = 44;
button_gap = 12;

var start_y = menu_y + 80;

buttons = [];
array_push(buttons, {id: "start", label: "Start Game", x: menu_x + (menu_width-button_w)/2, y: start_y, w: button_w, h: button_h});
array_push(buttons, {id: "loadout", label: "Loadout", x: menu_x + (menu_width-button_w)/2, y: start_y + (button_h+button_gap)*1, w: button_w, h: button_h});
array_push(buttons, {id: "options", label: "Toggle Ranges", x: menu_x + (menu_width-button_w)/2, y: start_y + (button_h+button_gap)*2, w: button_w, h: button_h});
array_push(buttons, {id: "quit", label: "Quit", x: menu_x + (menu_width-button_w)/2, y: start_y + (button_h+button_gap)*3, w: button_w, h: button_h});

hover_button = -1;

// Small title
title = "Gmome Attack";
subtitle = "Defend the garden from evil gnomes!";

// Debug
show_debug_message("obj_main_menu created (id=" + string(id) + ")");

// On creation, open the dedicated Loadout room so the Load screen is the first thing the player sees
var r_load = asset_get_index("Room_Load");
// Only auto-redirect to the Load screen when this menu was created in the Start room.
// This prevents instances of the main menu placed inside gameplay rooms from forcing a room change.
if (r_load != -1) {
	if (is_undefined(Start) == false && room == Start) {
		room_goto(r_load);
	} else {
		show_debug_message("obj_main_menu created in room " + string(room) + ": not redirecting to Room_Load");
	}
} else {
	show_debug_message("Room_Load not found; staying on main menu");
}
