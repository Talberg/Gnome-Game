/// @description Bomb Gnome Tower - AOE damage, slow fire

// Inherit from parent
event_inherited();

// Tower type
tower_type = "bomb";
tower_name = "Bomb Gnome";

// Cost and rarity
tower_cost = 150;
tower_color = c_red;

// Combat stats - AOE damage, slow cooldown
attack_range = 180;
attack_cooldown = 90; // 1.5 seconds
damage = 15;

// AOE specific
aoe_radius = 80; // Damage radius for explosions
aoe_damage = 8; // Damage to enemies in AOE

// Description
tower_description = "Explosive AOE damage to groups";
