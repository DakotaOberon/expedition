// Inherit the parent event
event_inherited();

// Dash to dodge
if (controls.checkPress("dash")) {
	dashTimer = 15;
	dashDirection = point_direction(x, y, mouse_x, mouse_y);
}

if (dashTimer > 0) {
	_xSpeed += lengthdir_x(4, dashDirection);
	_ySpeed += lengthdir_y(4, dashDirection);
	dashTimer -= 1;
}
