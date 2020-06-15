/// @description Update camera

// Check if follow is a valid instance
if (instance_exists(follow)) {
	// Update Destination
	xTo = follow.x;
	yTo = follow.y;
}

// Update object position (obj_camera)
x += (xTo - x) / 25; // transition from x to xTo smoothly (hence /25)
y += (yTo - y) / 25;

// Limit camera view to be within the bounds of the room
x = clamp(x, 0+view_w_half+buff, room_width-view_w_half-buff);
y = clamp(y, 0+view_h_half+buff, room_height-view_h_half-buff);

// Add screen shake
x += random_range(-shake_remain, shake_remain); // rand(-6,6)
y += random_range(-shake_remain, shake_remain);
// shake for 60 frames @60fps (reducing remaining shake)
shake_remain = max(0, shake_remain-((1/shake_duration)*shake_magnitude));

// Update camera view (using in-built functions)
camera_set_view_pos(cam, x-view_w_half, y-view_h_half); // centers player in camera view
