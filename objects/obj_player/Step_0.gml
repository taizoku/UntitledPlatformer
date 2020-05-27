/// @description Player movement/animation 

// INPUTS (KEYBOARD)
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_jump = keyboard_check(vk_up) || keyboard_check(ord("W"));

// Check if already using keyboard
if (key_left) || (key_right) || (key_jump) {
	controller = 0;	
}

// INPUTS (CONTROLLER)
// override keyboard values if a controller is connected
// set deadzone of 0.2 radius (range [-1, 1])
if(abs(gamepad_axis_value(0, gp_axislh)) > 0.2) {
	key_left = abs(min(gamepad_axis_value(0, gp_axislh), 0));
	key_right = abs(max(gamepad_axis_value(0, gp_axislh), 0));
}

// MOVEMENT
var move = key_right - key_left;

hsp = move * walksp; // horizontal speed
vsp += grv; // vertical speed

// jump: check if player is on the floor
var on_floor = place_meeting(x, y+1, obj_wall)
if (on_floor && key_jump) {
	vsp = -7;
}

// HORIZONTAL COLLISION
if (place_meeting(x+hsp, y, obj_wall)) {
	while (!place_meeting(x+sign(hsp), y, obj_wall)) {
		x += sign(hsp);
	}
	hsp = 0;
}
x += hsp;

// VERTICAL COLLISION
if (place_meeting(x, y+vsp, obj_wall)) {
	while (!place_meeting(x, y+sign(vsp), obj_wall)) {
		y += sign(vsp);
	}
	vsp = 0;
}
y = y + vsp;

move_wrap(sign(x), y, 16);

// ANIMATION
// check if the player is not on the floor
if (!on_floor) {
	sprite_index = spr_player_a;
	image_speed = 0;
	// if its positive, we're moving down (falling)
	if (sign(vsp) > 0) {
		image_index = 1;
	} else {
		image_index = 0;
	}
} else {
	image_speed = 1; // allow animating (set sprite speed)
	if (hsp == 0) {
		sprite_index = spr_player;
	} else {
		sprite_index = spr_player_walk;
	}
}
// orient the sprites in the direction of movement
if (hsp != 0) {
	image_xscale = sign(hsp); // 1 if +ve, 0 if -ve
}