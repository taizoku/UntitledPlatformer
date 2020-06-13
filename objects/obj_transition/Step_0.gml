/// @description Progress the transition

// OFF signifies we don't transition
if (mode != TRANS_MODE.OFF) {
	// We've arrived in the target room
	if (mode == TRANS_MODE.INTRO) {
		// Fade from black (1) to the room (0)
		// Transition moves fast then slows gradually
		percent = max(0, percent - max((percent/10), 0.005));
	} else {
		// Gets 10% of what's left up to 0.005
		percent = min(1, percent + max(((1 - percent)/10), 0.005));
	}
	
	// 
	if (percent == 1) || (percent == 0) {
		switch(mode) {
			case TRANS_MODE.INTRO:
				// If we're done with introducing the room
				// Turn transition
				mode = TRANS_MODE.OFF;
				break;
				
			case TRANS_MODE.NEXT:
				// move to next room (in room order)
				mode = TRANS_MODE.INTRO; // prep transition
				room_goto_next();
				break;
				
			case TRANS_MODE.GOTO:
				// move to desired room
				mode = TRANS_MODE.INTRO;
				room_goto(target);
				break;
				
			case TRANS_MODE.RESTART:
				game_restart();
				break;
		}
	}
}
