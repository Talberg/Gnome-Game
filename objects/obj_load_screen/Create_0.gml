/// @description Create the load/save screen UI

menu_x = 200;
menu_y = 180;
menu_width = 600;
menu_height = 300;
title = "Load or Start";
subtitle = "Load your saved loadout or start a new game";

// Only two actions on the start page: Load Default, New Game
var bx = menu_x + (menu_width - 240) / 2;
buttons = [
    { x: bx, y: menu_y + 120, w: 240, h: 56, label: "Load Default", action: "load" },
    { x: bx, y: menu_y + 200, w: 240, h: 56, label: "New Game", action: "new" }
];

hover_button = -1;
