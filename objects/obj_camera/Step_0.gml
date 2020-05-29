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
x = clamp(x, 0+view_w_half, room_width-view_w_half);
y = clamp(y, 0+view_h_half, room_height-view_h_half);

// Update camera view (using in-built functions)
camera_set_view_pos(cam, x-view_w_half, y-view_h_half); // centers player in camera view
