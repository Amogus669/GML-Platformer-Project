/// @desc Core Player Logic

// Get Player Inputs
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);

// Calculate Movement
var _move = key_right - key_left;
hsp = _move * walksp;
vsp = vsp + grv;


// Horizontal Collsion 
if(place_meeting(x+hsp,y,obj_wall))
{
	while (!place_meeting(x+sign(hsp),y,obj_wall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp;
// Vertical Collision
if(place_meeting(x,y+vsp,obj_wall))
{
	while (!place_meeting(x,y+sign(vsp),obj_wall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}
y = y + vsp;

//Jumping Mechanics
if( place_meeting(x, y+1, obj_wall) && (key_jump)) {
	vsp = -jumpsp;
}

//Animation States
if(!place_meeting(x, y+1, obj_wall))
{
	sprite_index = sp_jump;
	image_speed = 0;
	
	//Are we jumping?
	if(vsp < -4.5) {
	image_index = 1;
	}
	
	// Are we at the top?
	else if (vsp >= -4.5 && vsp <= 4.5) {
		image_index = 2;
	}
		
	// Are we falling?
	else if (vsp > 4.5) {
		image_index = 3;
	}

}
else {
	image_speed = 1;

	//Are we idle nor moving left/right
	if(hsp == 0) {
		sprite_index = sp_idle;
	}
	else {
		sprite_index = sp_playerrun;
	}
}
if(hsp != 0) image_xscale = sign(hsp);