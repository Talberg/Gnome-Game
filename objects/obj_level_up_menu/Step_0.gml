/// @description Handle reward card selection

var mx = mouse_x;
var my = mouse_y;

// Check which card is hovered
hover_card = -1;
for (var i = 0; i < array_length(reward_options); i++) {
    var cx = card_start_x + i * (card_w + card_gap);
    var cy = card_start_y;
    if (mx >= cx && mx <= cx + card_w && my >= cy && my <= cy + card_h) {
        hover_card = i;
        break;
    }
}

// Handle card click
if (hover_card >= 0 && mouse_check_button_pressed(mb_left)) {
    var reward = reward_options[hover_card];
    show_debug_message("[Level Up] Selected reward: " + reward.label);
    
    // Apply reward
    if (instance_exists(obj_game_manager)) {
        var gm = obj_game_manager;
        
        switch (reward.type) {
            case "damage_boost":
                if (!variable_global_exists("damage_multiplier")) global.damage_multiplier = 1.0;
                global.damage_multiplier += 0.1;
                show_debug_message("[Reward] Damage boost applied: " + string(global.damage_multiplier * 100) + "%");
                break;
                
            case "range_boost":
                if (!variable_global_exists("range_multiplier")) global.range_multiplier = 1.0;
                global.range_multiplier += 0.15;
                show_debug_message("[Reward] Range boost applied: " + string(global.range_multiplier * 100) + "%");
                break;
                
            case "fire_rate_boost":
                if (!variable_global_exists("fire_rate_multiplier")) global.fire_rate_multiplier = 1.0;
                global.fire_rate_multiplier += 0.1;
                show_debug_message("[Reward] Fire rate boost applied: " + string(global.fire_rate_multiplier * 100) + "%");
                break;
                
            case "gold_bonus":
                gm.gold += 100;
                show_debug_message("[Reward] +100 gold (now: " + string(gm.gold) + ")");
                break;
                
            case "extra_life":
                gm.lives += 1;
                show_debug_message("[Reward] +1 life (now: " + string(gm.lives) + ")");
                break;
                
            case "cooldown_reduce":
                if (!variable_global_exists("cooldown_multiplier")) global.cooldown_multiplier = 1.0;
                global.cooldown_multiplier -= 0.2;
                if (global.cooldown_multiplier < 0.2) global.cooldown_multiplier = 0.2; // Min 20% cooldown
                show_debug_message("[Reward] Cooldown reduced: " + string(global.cooldown_multiplier * 100) + "%");
                break;
                
            case "unlock_turret":
                // TODO: Implement turret unlocking system
                show_debug_message("[Reward] Turret unlock - not yet implemented");
                break;
        }
    }
    
    // Close menu and unpause
    instance_destroy();
}
