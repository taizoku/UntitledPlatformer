/// @description Size, variables and mode set-up

// gui: independent layer from where the camera is pointing
w = display_get_gui_width();
h = display_get_gui_height();
middle = h * 0.5; // half of gui height

// define state change constants
enum TRANS_MODE
{
	OFF,
	NEXT,
	GOTO,
	RESTART,
	INTRO
};

mode = TRANS_MODE.INTRO; // type of transition
percent = 1; // [0,1] transition fade
target = room; // room to transition to