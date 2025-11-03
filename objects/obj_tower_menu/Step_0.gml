/// @description Tower menu interaction

// Only destroy if we had a target and it's now gone. This prevents the menu
// from immediately destroying itself when it's created before the grid manager
// assigns `target_tower`.
if (target_tower != noone && !instance_exists(target_tower)) {
    show_debug_message("obj_tower_menu: target_tower no longer exists, destroying menu id=" + string(id));
    instance_destroy();
}

// Position the menu near the tower (top-right)
var tx = target_tower.x;
var ty = target_tower.y;
var mx = tx + 48;
var my = ty - menu_height - 8;

// Keep menu onscreen
mx = clamp(mx, 8, room_width - menu_width - 8);
my = clamp(my, 8, room_height - menu_height - 8);

x = mx; y = my;

// Mouse handling (GUI coords vs room coords - menu uses room coords)
hover_sell = false; hover_upgrade = false;
if (mouse_x >= x + button_padding && mouse_x <= x + button_padding + btn_w && mouse_y >= y + button_padding && mouse_y <= y + button_padding + btn_h) {
    hover_sell = true;
}
if (mouse_x >= x + button_padding * 2 + btn_w && mouse_x <= x + button_padding * 2 + btn_w + btn_w && mouse_y >= y + button_padding && mouse_y <= y + button_padding + btn_h) {
    hover_upgrade = true;
}

// Click handlers
if (mouse_check_button_pressed(mb_left)) {
    // Sell
    if (hover_sell) {
        // Refund percentage
        var refund_percent = 0.5;
        var refund_amount = 0;
        if (variable_instance_exists(target_tower, "tower_cost")) {
            refund_amount = floor(target_tower.tower_cost * refund_percent);
            obj_game_manager.gold += refund_amount;
        }

        // Return to pool (apply cooldown/increment quantity)
        if (instance_exists(obj_tower_pool)) {
            var pool = instance_find(obj_tower_pool, 0);
            var pool_list = pool.tower_pool;
            var found_index = -1;
            for (var j = 0; j < ds_list_size(pool_list); j++) {
                var td = pool_list[| j];
                if (td[? "object"] == target_tower.object_index) {
                    found_index = j; break;
                }
            }
            if (found_index >= 0) {
                var td = pool_list[| found_index];
                if (td[? "quantity"] >= 0) td[? "quantity"] = min(td[? "quantity"] + 1, td[? "max_quantity"]);
                td[? "cooldown"] = td[? "max_cooldown"];
            }
        }

        // Free grid cell
        if (variable_instance_exists(target_tower, "grid_x") && variable_instance_exists(target_tower, "grid_y")) {
            ds_grid_set(grid, target_tower.grid_x, target_tower.grid_y, 0);
            ds_grid_set(tower_grid, target_tower.grid_x, target_tower.grid_y, noone);
        }

        // Destroy tower and menu
        if (instance_exists(target_tower)) instance_destroy(target_tower);
        instance_destroy();
    }

    // Upgrade
    if (hover_upgrade) {
        // Check upgrade level
        if (variable_instance_exists(target_tower, "upgrade_level")) {
            var cur_level = target_tower.upgrade_level;
        } else {
            var cur_level = 0;
        }
        if (cur_level >= max_upgrade_level) {
            // cannot upgrade further
        } else {
            // Calculate upgrade cost (75% of base cost * (level+1))
            var base_cost = variable_instance_exists(target_tower, "tower_cost") ? target_tower.tower_cost : 0;
            var upgrade_cost = ceil(base_cost * 0.75 * (cur_level + 1));
            if (obj_game_manager.gold >= upgrade_cost) {
                obj_game_manager.gold -= upgrade_cost;
                // Apply upgrade: increase damage and slightly improve cooldown
                if (variable_instance_exists(target_tower, "damage")) {
                    if (!variable_instance_exists(target_tower, "upgrade_level")) target_tower.upgrade_level = 0;
                    target_tower.upgrade_level += 1;
                    target_tower.damage = ceil(target_tower.damage * upgrade_multiplier);
                    // Reduce cooldown by 10% per upgrade (round)
                    if (variable_instance_exists(target_tower, "attack_cooldown")) {
                        target_tower.attack_cooldown = max(1, ceil(target_tower.attack_cooldown * 0.9));
                    }
                }
                // Close menu
                instance_destroy();
            }
        }
    }
}

// Close menu on outside click or ESC
if (mouse_check_button_pressed(mb_left) && !hover_sell && !hover_upgrade) {
    // clicked elsewhere
    instance_destroy();
}
if (keyboard_check_pressed(vk_escape)) instance_destroy();