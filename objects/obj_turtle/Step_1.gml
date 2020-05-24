/// @description For turtle death

if (hp == 0) {
	with(instance_create_layer(x, y, "Enemy", obj_dead)) {
		direction = other.hitfrom; // dir = bullet direction
		hsp = lengthdir_x(3, direction);
		vsp = lengthdir_y(3, direction)-2;
		// prevent scaling if shot from directly below
		if (sign(hsp) != 0) {
			image_xscale = sign(hsp); // orient image based on hsp vector
		}
	}
	instance_destroy();
}
