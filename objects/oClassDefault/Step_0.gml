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

// Cleave
if (controls.checkPress("cleave") && cleave.cooldownTimer <=0) {
	cleave.timer = cleave.length;
	cleave.cooldownTimer = cleave.cooldown;
	var xDir = lengthdir_x(cleave.distance, attackDirection) + cleave.xOffSet;
	var yDir = lengthdir_y(cleave.distance, attackDirection) + cleave.yOffSet;
	cleave.hitb = hitcircle(x + xDir, y + yDir, cleave.radius, cleave.damage, cleave.length, allyTag); 
}

if (cleave.timer > 0) {
	if (instance_exists(cleave.hitb)) {
		var xDir = x + lengthdir_x(cleave.distance, attackDirection) + cleave.xOffSet;
		var yDir = y + lengthdir_y(cleave.distance, attackDirection) + cleave.yOffSet;
		cleave.hitb.x = xDir;
		cleave.hitb.y = yDir;
	}
	cleave.timer -= 1;
} else if (cleave.cooldownTimer > 0) {
	cleave.cooldownTimer -= 1;
}
