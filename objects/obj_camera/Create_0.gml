/// @description Set-up camera

cam = view_camera[0]; // enable viewport 0 in cam
follow = obj_player; // target for camera to follow
view_w_half = camera_get_view_width(cam) / 2; // half of viewport width
view_h_half = camera_get_view_height(cam) / 2; // half of viewport height
xTo = xstart; // tracks x of where the camera is moving towards
yTo = ystart; // tracks y of where the camera is moving towards
