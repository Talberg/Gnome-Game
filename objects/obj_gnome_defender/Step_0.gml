/// @description Attack logic

// Countdown attack timer
if (attack_timer > 0) {
    attack_timer--;
}

// Check if current target is still valid
if (instance_exists(target)) {
    var dist = point_distance(x, y, target.x, target.y);
    if (dist > attack_range || target.hp <= 0) {
        target = noone;
    }
}

// Find a new target if we don't have one
if (!instance_exists(target)) {
    target = noone;
    
    // Look for enemies in our lane (same y position approximately)
    var nearest = noone;
    var nearest_dist = attack_range;
    
    with (obj_evil_gnome) {
        // Check if enemy is roughly in the same lane
        if (abs(y - other.y) < 40) {
            var dist = point_distance(x, y, other.x, other.y);
            if (dist <= other.attack_range && dist < nearest_dist) {
                nearest = id;
                nearest_dist = dist;
            }
        }
    }
    
    target = nearest;
}

// Attack if we have a target and cooldown is ready
if (instance_exists(target) && attack_timer <= 0) {
    // Create projectile
    var proj = instance_create_depth(x, y, depth - 1, obj_projectile);
    proj.target = target;
    proj.damage = damage;
    
    attack_timer = attack_cooldown;
}
