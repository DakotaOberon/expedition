// Run step scripts
updateDirection();

// Set x and y goals
if (self.checkAnyMoveKeys()) {
	self._xSpeedGoal = lengthdir_x(self.moveSpeed, self._direction);
	self._ySpeedGoal = lengthdir_y(self.moveSpeed, self._direction);
} else {
	self._xSpeedGoal = 0;
	self._ySpeedGoal = 0;
}

// Inherit the parent event
event_inherited();

// Check for backOut button being pressed
if (controls.checkPress("backOut")) {
	instance_destroy();
}

// Camera Step
if (camera) {
	if (gamepadSlot >= 0) {
		// Get right thumbstick values
		var _rh = gamepad_axis_value(gamepadSlot, gp_axisrh);
		var _rv =  gamepad_axis_value(gamepadSlot, gp_axisrv);
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
