/**
* Initiate controls
*
* @function		PlayerControlsInit()
* @return		{Controls}
*/
function PlayerControlsInit(gamepadSlot=-1) {
	// Set controls
	// TODO: Should be moved into an ini file
	if (gamepadSlot >= 0) {
		self.gamepadSlot = gamepadSlot;
		self.controls
			.add("moveLeft", gp_axislh, KeyType.gpAxis, gamepadSlot, -1)
			.add("moveRight", gp_axislh, KeyType.gpAxis, gamepadSlot, 1)
			.add("moveUp", gp_axislv, KeyType.gpAxis, gamepadSlot, -1)
			.add("moveDown", gp_axislv, KeyType.gpAxis, gamepadSlot, 1)
			.add("dash", gp_shoulderlb, KeyType.gamepad, gamepadSlot)
			.add("backOut", gp_select, KeyType.gamepad, gamepadSlot);
	} else {
		self.controls
			.add("moveLeft", ord("A"))
			.add("moveRight", ord("D"))
			.add("moveUp", ord("W"))
			.add("moveDown", ord("S"))
			.add("dash", ord("E"))
			.add("backOut", vk_escape);
	}

	return self.controls
}

/**
* Update players direction value
*
* @function		PlayerUpdateDirection()
* @return		{self}
*/
function PlayerUpdateDirection() {
	var lk = self.controls.check("moveLeft");
	var rk = self.controls.check("moveRight");
	var uk = self.controls.check("moveUp");
	var dk = self.controls.check("moveDown");

	log("lk:", lk, "rk:", rk, "uk:", uk, "dk:", dk);
	self._direction = point_direction(0, 0, rk - lk, dk - uk);
	log("Direction:", self._direction);

	return self;
}

/**
* Update players movement
*
* @function		PlayerUpdateMovement(speed)
* @return		{self}
*/
function PlayerUpdateMovement() {
	// Set friction
	var f = self._friction;
	if (place_meeting(x, y, oSurface)) {
		var surf = collision_point(x, y, oSurface, 0, 1);
		f = surf._friction;
	}

	// Set x and y goals
	if (self.checkAnyMoveKeys()) {
		self._xSpeedGoal = lengthdir_x(self.moveSpeed, self._direction);
		self._ySpeedGoal = lengthdir_y(self.moveSpeed, self._direction);
	} else {
		self._xSpeedGoal = 0;
		self._ySpeedGoal = 0;
	}

	// Get x and y acceleration
	self._directionGoal = point_direction(self._currentXSpeed, self._currentYSpeed, self._xSpeedGoal, self._ySpeedGoal);
	self._xAcceleration = lengthdir_x((self._acceleration * f), self._directionGoal);
	self._yAcceleration = lengthdir_y((self._acceleration * f), self._directionGoal);

	// Update current x and y move speeds
	self._currentXSpeed = approach(self._currentXSpeed, self._xSpeedGoal, self._xAcceleration);
	self._currentYSpeed = approach(self._currentYSpeed, self._ySpeedGoal, self._yAcceleration);

	return self;
}

/**
* Checks if any of the Players movement keys are being held
*
* @function		PlayerCheckAnyMoveKeys()
* @return		{self}
*/
function PlayerCheckAnyMoveKeys() {
	return (
		self.controls.check("moveLeft")
		|| self.controls.check("moveRight")
		|| self.controls.check("moveUp")
		|| self.controls.check("moveDown")
	)
	
	return self;
}
