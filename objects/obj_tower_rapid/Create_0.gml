/// @description Rapid Fire Gnome Tower - Fast attacks, low damage

// Inherit from parent
event_inherited();

// Tower type
tower_type = "rapid";
tower_name = "Rapid Gnome";

// Cost and rarity
tower_cost = 75;
tower_color = c_orange;

// Combat stats - Fast fire rate, lower damage
attack_range = 150;
attack_cooldown = 20; // 0.33 seconds
damage = 5;

// Description
tower_description = "Rapid fire attacks, great vs swarms";
