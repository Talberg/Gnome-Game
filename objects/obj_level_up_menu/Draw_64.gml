/// @description Draw level-up menu

// Flash effect (bright gold flash that fades out)
if (flash_alpha > 0) {
    draw_set_alpha(flash_alpha * 0.6);
    draw_set_color(c_yellow);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
}

// Expanding rings effect (draw multiple rings from center)
if (ring_radius < ring_max_radius) {
    var cx = room_width / 2;
    var cy = room_height / 2;
    
    // Draw 3 rings at different stages
    for (var i = 0; i < 3; i++) {
        var r = ring_radius - (i * 150);
        if (r > 0 && r < ring_max_radius) {
            var ring_alpha = 1 - (r / ring_max_radius);
            draw_set_alpha(ring_alpha * 0.4);
            draw_set_color(c_lime);
            draw_circle(cx, cy, r, true);
            draw_circle(cx, cy, r + 2, true);
        }
    }
    draw_set_alpha(1);
}

// Dim the game background
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);

// Menu panel
draw_set_color(c_dkgray);
draw_rectangle(menu_x, menu_y, menu_x + menu_w, menu_y + menu_h, false);
draw_set_color(c_yellow);
draw_rectangle(menu_x, menu_y, menu_x + menu_w, menu_y + menu_h, true);
draw_rectangle(menu_x + 2, menu_y + 2, menu_x + menu_w - 2, menu_y + menu_h - 2, true);

// Title
draw_set_color(c_lime);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
if (variable_global_exists("font_default")) draw_set_font(font_default);
draw_text(menu_x + menu_w/2, menu_y + 24, title);

// Subtitle
draw_set_color(c_white);
draw_text(menu_x + menu_w/2, menu_y + 60, subtitle);

// Instructions
draw_set_color(c_ltgray);
draw_text(menu_x + menu_w/2, menu_y + 90, "Click a card to select your reward");

// Draw reward cards
for (var i = 0; i < array_length(reward_options); i++) {
    var reward = reward_options[i];
    var cx = card_start_x + i * (card_w + card_gap);
    var cy = card_start_y;
    var is_hover = (i == hover_card);
    
    // Card background
    draw_set_color(is_hover ? c_lime : c_white);
    draw_rectangle(cx, cy, cx + card_w, cy + card_h, false);
    
    // Card border
    draw_set_color(c_black);
    draw_rectangle(cx, cy, cx + card_w, cy + card_h, true);
    draw_rectangle(cx + 1, cy + 1, cx + card_w - 1, cy + card_h - 1, true);
    
    // Card content
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    
    // Reward label
    draw_text(cx + card_w/2, cy + 20, reward.label);
    
    // Reward description (wrapped text)
    draw_set_color(c_dkgray);
    draw_set_halign(fa_left);
    var desc_lines = string_split(reward.desc, " ", true);
    var line_y = cy + 60;
    var current_line = "";
    
    for (var j = 0; j < array_length(desc_lines); j++) {
        var test_line = current_line + (current_line == "" ? "" : " ") + desc_lines[j];
        if (string_width(test_line) > card_w - 20) {
            draw_text(cx + 10, line_y, current_line);
            current_line = desc_lines[j];
            line_y += 16;
        } else {
            current_line = test_line;
        }
    }
    if (current_line != "") {
        draw_text(cx + 10, line_y, current_line);
    }
    
    // Hover indicator
    if (is_hover) {
        draw_set_color(c_yellow);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(cx + card_w/2, cy + card_h - 10, "[ CLICK TO SELECT ]");
    }
}

// Reset drawing settings
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
