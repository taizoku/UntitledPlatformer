/// @desc ScreenShake(magnitude, frames)
/// @arg magnitude sets strength of the shake (offset radius from center)
/// @arg frames sets duration of shaking in frames (60 = 1s)
function ScreenShake() {

	with (obj_camera) {
		// prioritise larger magnitude shakes
		// so if new shake is more violent than the current one (if any)
		if (argument[0] > shake_remain) {
			shake_magnitude = argument[0];
			shake_remain = argument[0];
			shake_duration = argument[1];
		}
	}



}
