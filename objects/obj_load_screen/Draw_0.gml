/// @description Draw the save slot selection UI

// Dim background
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(0,0,room_width,room_height,false);
draw_set_alpha(1);

// Panel
draw_set_color(c_dkgray);
draw_rectangle(menu_x, menu_y, menu_x+menu_width, menu_y+menu_height, false);

// Border
draw_set_color(c_white);
draw_rectangle(menu_x, menu_y, menu_x+menu_width, menu_y+menu_height, true);

// Title
draw_set_color(c_lime);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
if (variable_global_exists("font_default")) draw_set_font(font_default);
draw_text(menu_x + menu_width/2, menu_y + 20, title);

// Draw save slots
for (var i = 0; i < array_length(save_slots); i++) {
    var slot = save_slots[i];
    var sx = slot_start_x + i * (slot_card_w + slot_gap);
    var sy = slot_start_y;
    var is_hover = (i == hover_slot);
    
    // Slot card background
    if (slot.exists) {
        draw_set_color(is_hover ? c_yellow : c_white);
    } else {
        draw_set_color(is_hover ? c_dkgray : c_gray);
    }
    draw_rectangle(sx, sy, sx + slot_card_w, sy + slot_card_h, false);
    
    // Slot border
    draw_set_color(c_black);
    draw_rectangle(sx, sy, sx + slot_card_w, sy + slot_card_h, true);
    
    // Slot content
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    if (slot.exists) {
        // Show save data
        draw_text(sx + 12, sy + 12, "Slot " + string(i + 1));
        draw_text(sx + 12, sy + 36, "Turret: " + slot.turret);
        draw_text(sx + 12, sy + 60, "Gold: " + string(slot.gold));
        draw_set_color(c_dkgray);
        draw_text(sx + 12, sy + 84, string_copy(slot.timestamp, 1, 16));
    } else {
        // Empty slot
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text(sx + slot_card_w/2, sy + slot_card_h/2, "[Empty Slot]");
    }
}

// New Game button
var b = new_game_btn;
draw_set_color(hover_new_game ? c_lime : c_black);
draw_rectangle(b.x, b.y, b.x + b.w, b.y + b.h, false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(b.x + b.w/2, b.y + b.h/2, b.label);

// Reset
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
