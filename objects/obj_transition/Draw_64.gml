/// @description Draw black transition bars
/// Note: Draw GUI draws onto the screen, not the room
/// So doesn't matter where the player is, it will overlay

// if mode is OFF, we don't want to draw anything
if (mode != TRANS_MODE.OFF) {
	draw_set_color(c_black);
	draw_rectangle(0, 0, w, percent*middle, false); // fill rect to half screen
	draw_rectangle(0, h, w, h-(percent*middle), false); // bottom rectangle
}

// DEBUG: draw transition percentage on top left of screen
draw_set_color(c_white);
draw_text(50, 50, string(percent));