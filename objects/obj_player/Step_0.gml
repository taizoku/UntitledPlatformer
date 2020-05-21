 /// @description Player movement/animation 

// INPUTS
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check(vk_up);

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