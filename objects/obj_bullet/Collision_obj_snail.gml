/// @description bullet hits turtle (enemy)

// with the enemy (turtle)
with (other) {
	hp--;
	flash = 3;
	hitfrom = other.direction; // store direction of bullet
}
// destroy bullet
instance_destroy();