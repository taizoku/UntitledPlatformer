/// @description Player movement/animation 

#region // INPUT CONFIGURATION

if (hascontrol) {
	// Keyboard Input
	key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
	key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
	key_jump = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
	key_fall = keyboard_check(vk_down) || keyboard_check(ord("S"));

	// Check if already using keyboard
	if (key_left) || (key_right) || (key_jump) {
		controller = 0;	
	}

	// Controller Input
	// override keyboard values if a controller is connected
	// set deadzone of 0.2 radius (range [-1, 1])
	if(abs(gamepad_axis_value(0, gp_axislh)) > 0.2) {
		controller = 1; // set controller state for aiming
		// obtain value between -1 and 1
		key_left = abs(min(gamepad_axis_value(0, gp_axislh), 0));
		key_right = abs(max(gamepad_axis_value(0, gp_axislh), 0));
	}

	if(gamepad_button_check_pressed(0, gp_face1)) {
		controller = 1;
		key_jump = 1;
	}
	
} else {
		// If control is taken away from the player:
		// Force input flags OFF
		key_left = 0;
		key_right = 0;
		key_jump = 0;
		key_fall = 0;
}

#endregion

#region // MOVEMENT CALCULATION

// Reduce delay
wjump_delay = max(wjump_delay-1, 0);

// Restrict moving left and right until there is no delay
if (wjump_delay == 0) {
	// Calculate Horizontal Movement
	var dir = key_right - key_left; // direction

	//hsp = dir * hsp_acc; // horizontal speed
	hsp = dir * walksp; // horizontal speed
	hsp = clamp(hsp, -walksp, walksp); // need if adding
}

// Wall Jump
if (on_wall != 0) && (!on_ground) && (key_jump) {
	wjump_delay = wjump_delay_max; // set delay after a wall jump
	hsp = -on_wall * hsp_wjump;
	vsp = vsp_wjump;
}

// Calculate Vertical Movement
var grv_final = grv;
var vsp_max_final = vsp_max;

// if on a wall and moving downwards
if (on_wall != 0) && (vsp > 0) {
	grv_final = grv_wall;
	vsp_max_final = vsp_max_wall;
}

vsp += grv_final; // vertical speed
vsp = clamp(vsp, -vsp_max_final, vsp_max_final); // limit vsp

// Ground Jump
// * check if player is on the floor *
// add jump buffer so jump is more forgiving off ledges
var on_floor = place_meeting(x, y+1, obj_wall)
if (on_floor && key_jump) {
	vsp = jumpsp;
}

// Fast Fall
// * player presses down in air *
if (!on_floor && key_fall) {
	vsp = -jumpsp;
}

// Horizontal Collision
if (place_meeting(x+hsp, y, obj_wall)) {
	while (!place_meeting(x+sign(hsp), y, obj_wall)) {
		x += sign(hsp);
	}
	hsp = 0;
}

// Horizontal Movement
x += hsp;

// Vertical Collision
if (place_meeting(x, y+vsp, obj_wall)) {
	while (!place_meeting(x, y+sign(vsp), obj_wall)) {
		y += sign(vsp);
	}
	vsp = 0;
}

// Vertical Movement
y += vsp;

// Calculate player status
on_wall = place_meeting(x+1, y, obj_wall) - place_meeting(x-1, y, obj_wall);
on_ground = place_meeting(x, y+1, obj_wall);
if (on_ground) {
	jump_buff = 6; // reset jump buffer after movement
}

#endregion 

#region // ANIMATION

// If the player is in the air
if (!on_ground) {
	// And against a wall
	if (on_wall != 0) {
		sprite_index = spr_player_wall;
		image_xscale = on_wall;
		
		// Coordinates of player hitbox
		var side = bbox_left;
		if (on_wall == 1) {
			side = bbox_right;	
		}
		dust++; // increase wall friction trail
		
		// Dust Particles
		// If player is falling for more than 3 frames
		if ((dust > 2) && (vsp > 0)) {
			with(instance_create_layer(side, bbox_top, "Particles", obj_dust)) {
				other.dust = 0; // reset dust count to 0
				hsp = -other.on_wall * 0.5; // give dust some horizontal speed away from the wallp
			}
		}
	} else {
		dust = 0;
		sprite_index = spr_player_a;
		image_speed = 0; // Fix sprite (no animation)
		
		// 0: Rising
		// 1: Falling
		image_index = (vsp > 0);
	}
} else {
	image_speed = 1; // allow animating (set sprite speed)
	if (hsp == 0) {
		sprite_index = spr_player;
	} else {
		sprite_index = spr_player_run;
	}
}
// orient the sprites in the direction of movement
if (hsp != 0) {
	image_xscale = sign(hsp); // 1 if +ve, 0 if -ve
}

#endregion