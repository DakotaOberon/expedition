// Run step scripts from Player
player.updateDirection();
player.updateMovement(moveSpeed);

// Check for backOut button being pressed
if (player.controls.checkPress("backOut")) {
	// Clean up global variables of player
	global.players.remove(global.players.indexOf(id));

	// Reset camera
	global.camera.remove();

	// Set playing to false
	var gpSlot = player.gamepad;
	if (gpSlot >= 0) {
		global.controllers.value[gpSlot].setPlaying(false);
	} else {
		global.keyboard = false;
	}
	global.playing -= 1;

	// Destroy this object
	instance_destroy(self);
}

// Update player position
x += player._xSpeed;
y += player._ySpeed;

// Inherit the parent event
event_inherited();

// Camera Step
if (camera) {
	if (player.gamepad >= 0) {
		// Get right thumbstick values
		var _rh = gamepad_axis_value(player.gamepad, gp_axisrh);
		var _rv =  gamepad_axis_value(player.gamepad, gp_axisrv);
		// Set direction and distance
		var _direction = point_direction(0, 0, _rh, _rv);
		var _distance = point_distance(x, y, x + (_rh * 100), y  + (_rv * 100));
		camera.step(_direction, _distance);
	} else {
		// Set direction and distance
		var _mouseDirection = point_direction(x, y, mouse_x, mouse_y);
		var _mouseDistance = point_distance(x, y, mouse_x, mouse_y);
		camera.step(_mouseDirection, _mouseDistance);
	}
}
