/// @description Create enemy hit flash
// overrides default draw event

draw_self(); // normal drawing event

// overlay flash when enemy is hit
if (flash > 0) {
	flash --; // flash for 3 frames
	shader_set(sh_white); // turn on shader
	draw_self(); // draw the enemy
	shader_reset(); // revert to default (so not everything is white)
}