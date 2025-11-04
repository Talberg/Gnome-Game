/// @description Float upward and fade out

// Float upward
y_offset -= float_speed;

// Fade out
timer += 1;
alpha = 1 - (timer / lifetime);

// Destroy when done
if (timer >= lifetime) {
    instance_destroy();
}
