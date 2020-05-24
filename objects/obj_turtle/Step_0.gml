/// @description Enemy movement/animation 

vsp += grv; // vertical speed

// HORIZONTAL COLLISION
if (place_meeting(x+hsp, y, obj_wall)) {
	while (!place_meeting(x+sign(hsp), y, obj_wall)) {
		x += sign(hsp);
	}
	hsp = -hsp; // turn around when hitting a wall
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

move_wrap(x, y, 8);

// ANIMATION
// check if the player is not on the floor
if (!place_meeting(x, y+1, obj_wall)) {
	sprite_index = spr_turtle_a;
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
		sprite_index = spr_turtle;
	} else {
		sprite_index = spr_turtle_walk;
	}
}
// orient the sprites in the direction of movement
if (hsp != 0) {
	image_xscale = sign(hsp); // 1 if +ve, 0 if -ve
}

if (hp < 0) {
	instance_destroy();
}