/// @description Attack logic

// Countdown attack timer
if (attack_timer > 0) {
    attack_timer--;
}

// Check if current target is still valid (use upgraded range)
if (instance_exists(target)) {
    var dist = point_distance(x, y, target.x, target.y);
    var effective_range = attack_range * global.range_multiplier;
    if (dist > effective_range || target.hp <= 0) {
        target = noone;
    }
}

// Find a new target if we don't have one (use upgraded range)
if (!instance_exists(target)) {
    target = noone;
    
    // Look for enemies in our lane (same y position approximately)
    var nearest = noone;
    var effective_range = attack_range * global.range_multiplier;
    var nearest_dist = effective_range;
    
    with (obj_evil_gnome) {
        // Check if enemy is roughly in the same lane
        if (abs(y - other.y) < 40) {
            var dist = point_distance(x, y, other.x, other.y);
            var other_effective_range = other.attack_range * global.range_multiplier;
            if (dist <= other_effective_range && dist < nearest_dist) {
                nearest = id;
                nearest_dist = dist;
            }
        }
    }
    
    target = nearest;
}

// Attack if we have a target and cooldown is ready
if (instance_exists(target) && attack_timer <= 0) {
    // Create projectile with upgraded damage
    var proj = instance_create_depth(x, y, depth - 1, obj_projectile);
    proj.target = target;
    proj.damage = damage * global.damage_multiplier;
    
    // Apply cooldown multiplier (lower is better)
    attack_timer = attack_cooldown * global.cooldown_multiplier;
}

// Mouse click to open tower menu (left click on this tower)
if (mouse_check_button_pressed(mb_left) && (!instance_exists(obj_tower_pool) || !obj_tower_pool.is_dragging)) {
    // Avoid opening multiple menus for the same tower
    var already = false;
    var menu_obj_index = asset_get_index("obj_tower_menu");
    if (menu_obj_index != -1) {
        var menu_count = instance_number(menu_obj_index);
        for (var mi = 0; mi < menu_count; mi++) {
            var m_inst = instance_find(menu_obj_index, mi);
            if (m_inst != noone && variable_instance_exists(m_inst, "target_tower")) {
                if (variable_instance_get(m_inst, "target_tower") == id) {
                    already = true;
                    break;
                }
            }
        }
    }
    if (!already) {
        // Check if mouse is over this tower's sprite rectangle
        var mx = mouse_x; var my = mouse_y;
        var sw = 32; var sh = 32;
        if (sprite_exists(sprite_index)) {
            sw = sprite_get_width(sprite_index);
            sh = sprite_get_height(sprite_index);
        }
        var left = x - sw/2; var right = x + sw/2;
        var top = y - sh/2; var bottom = y + sh/2;
        if (mx >= left && mx <= right && my >= top && my <= bottom) {
            var menu_index = asset_get_index("obj_tower_menu");
            if (menu_index != -1) {
                var menu_x = x + 48;
                var menu_y = y - 48;
                var menu_inst = instance_create_depth(menu_x, menu_y, -100000, menu_index);
                if (menu_inst != noone) {
                    variable_instance_set(menu_inst, "target_tower", id);
                    show_debug_message("Opened tower menu (menu id=" + string(menu_inst) + ") for tower id=" + string(id));
                }
            }
        }
    }
}
