/// @description Bomb tower special AOE attack

// Inherit parent Step behavior
event_inherited();

// Override the attack to add AOE damage
// We check if we just shot (attack_timer == attack_cooldown - 1)
if (instance_exists(target) && attack_timer == attack_cooldown - 1) {
    // Deal AOE damage to all enemies near the primary target
    with (obj_evil_gnome) {
        var dist_to_target = point_distance(x, y, other.target.x, other.target.y);
        
        // If within AOE radius (but not the primary target)
        if (dist_to_target <= other.aoe_radius && id != other.target) {
            hp -= other.aoe_damage;
            
            // Visual feedback - flash white
            image_blend = c_white;
            alarm[1] = 3; // Flash duration
        }
    }
}
