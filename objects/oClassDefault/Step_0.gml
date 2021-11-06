// Inherit the parent event
event_inherited();

// Sprint code
if (controls.check("sprint")) {
	moveSpeed = sprint._speed;
} else {
	moveSpeed = sprint.normalSpeed;
}

// Dash to dodge
if (controls.checkPress("dash") && dash.cooldownTimer <= 0) {
	// Set dash timer and direction
	dash.timer = dash.length;
	dash._direction = point_direction(x, y, mouse_x, mouse_y);
	// Set dash origin for drawing
	dash.drawX = x;
	dash.drawY = y;
	dash.cooldownTimer = dash.cooldown;
	
	// Set invincibility
	if (invincibleTimer < dash.length) {
		invincibleTimer = dash.length;
	}
}

if (dash.timer > 0) {
	// Set current speed in direction of dash
	_currentXSpeed = lengthdir_x(dash._speed, dash._direction);
	_currentYSpeed = lengthdir_y(dash._speed, dash._direction);
	dash.timer -= 1;
} else if (dash.cooldownTimer > 0) {
	dash.cooldownTimer -= 1;
}

// Passive
	// Temporary until damage in place
var tookDamage = true;

if (tookDamage) && (passive.cooldownTimer <= 0) {
	// Set passive timer
	passive.timer = passive.length;
	// Set passive cooldown
	passive.cooldownTimer = passive.cooldown;

	// Set invincibility
	if (invincibleTimer < passive.length) {
		invincibleTimer = passive.length;
	}
}

if (passive.timer > 0) {
	// Reduce passive timer
	passive.timer -= 1;
} else if (passive.cooldownTimer > 0) {
	// Reduce passive cooldown if it is no longer active
	passive.cooldownTimer -= 1;
}
