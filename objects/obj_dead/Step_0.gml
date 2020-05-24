/// @description Insert description here
// You can write your code in this editor
if (done == 0) {
	vsp += grv; // vertical speed

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
		// if we're moving down after finding a vertical collision
		if (vsp > 0) {
			done = 1; // prevent looping again
			image_index = 3;
			image_speed = 0; // set to covered shell
		}
		while (!place_meeting(x, y+sign(vsp), obj_wall)) {
			y += sign(vsp);
		}
		vsp = 0;
	}
	y = y + vsp;
}