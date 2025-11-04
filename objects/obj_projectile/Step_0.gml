/// @description Move towards target

// Check if target still exists
if (!instance_exists(target)) {
    instance_destroy();
    exit;
}

// Move towards target
var dir = point_direction(x, y, target.x, target.y);
x += lengthdir_x(move_speed, dir);
y += lengthdir_y(move_speed, dir);

// Check if hit target
var dist = point_distance(x, y, target.x, target.y);
if (dist < 10) {
    // Deal damage
    target.hp -= damage;
    
    // Show damage number
    var dmg_num = instance_create_depth(target.x, target.y - 20, -1000, obj_damage_number);
    dmg_num.damage_text = string(damage);
    
    instance_destroy();
}

// Destroy if off screen
if (x < -50 || x > room_width + 50 || y < -50 || y > room_height + 50) {
    instance_destroy();
}
