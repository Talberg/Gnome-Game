/// @description Turret selection screen initialization

menu_x = 120;
menu_y = 80;
menu_w = room_width - 240;
menu_h = room_height - 160;
title = "Select Your Turrets";
title = "Select Your Turret";
subtitle = "Pick one turret for the upcoming run";

// Simple list of turret types (names must match object names or identifiers used later)
turret_types = [
    { id: "obj_tower_basic", label: "Basic Gnome" },
    { id: "obj_tower_sniper", label: "Sniper Gnome" },
    { id: "obj_tower_rapid", label: "Rapid-Fire Gnome" },
    { id: "obj_tower_bomb", label: "Bomb Gnome" }
];

// Selection state (boolean per type)
selected = array_create(array_length(turret_types), false);
max_select = 1;

// Start button
btn_start = { x: menu_x + menu_w - 220, y: menu_y + menu_h - 80, w: 180, h: 56, label: "Start Run" };

hover_index = -1;
