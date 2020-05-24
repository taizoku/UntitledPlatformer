/// @description For wall collisions

// This way even shooting at the floor shows the muzzle flash
if (place_meeting(x, y, obj_wall)) {
	instance_destroy();	
}
