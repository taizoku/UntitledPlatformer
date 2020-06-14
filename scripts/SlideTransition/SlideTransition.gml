/// @description SlideTransition(mode, targetRoom)
/// @arg mode sets transition mode between NEXT, RESTART and GOTO
/// @arg target sets target room when using GOTO mode

with (obj_transition) {
	mode = argument[0]; // set mode to first arg
	// if target arg is passed
	if (argument_count > 1) {
		target = argument[1];	
	}
}
