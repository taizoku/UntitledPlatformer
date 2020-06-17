 /// @description Player variables 

// Speed attributes
hsp = 0; // horizontal speed
vsp = 0; // vertical speed
walksp = 2; // walk speed
jumpsp = -4; // jump speed

// Acceleration
hsp_acc = 0.5;

// Buffers
jump_buff = 0;
wjump_delay = 0;

// Clamp Max Values
vsp_max = 10; // max falling speed
vsp_max_wall = 4; // slower falling speed against the wall
wjump_delay_max = 12; // for 17 frames release control on movement after wjump

// Wall Jump Speeds
hsp_wjump = 2;
vsp_wjump = -3;

// Friction
fric_ground = 0.5;
fric_air = 0.15;

// Gravity
grv = 0.2; // gravity
grv_wall = 0.05;

// Player States
on_ground = false;
on_wall = 0;

// Particles
dust = 0; // dust particle when player is sliding

// Control States
controller = false;
hascontrol = true;