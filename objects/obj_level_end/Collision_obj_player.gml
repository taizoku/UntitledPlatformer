/// @description Move to next room

// can still collide even if invisible
with (obj_player) {
	if (hascontrol) {
		hascontrol = false;
		// move to specified room (defined in the creation code)
		SlideTransition(TRANS_MODE.GOTO, other.target)
	}
}
