/// @description Gnome Defender Initialization

// Which grid cell this tower is in
grid_x = 0;
grid_y = 0;

// Visual
sprite_index = spr_gnome_defender;
image_speed = 0;

// Combat stats
attack_range = 200;
attack_cooldown = 60; // frames between attacks
attack_timer = 0;
damage = 10;

// Target tracking
target = noone;
