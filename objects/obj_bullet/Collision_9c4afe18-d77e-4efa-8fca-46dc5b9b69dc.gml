/// @description bullet hits turtle (enemy)

// with the enemy (turtle)
with (other) {
	hp--;
	flash = 3;
}
// destroy bullet
instance_destroy();