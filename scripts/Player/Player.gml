/**
* Initiate controls
*
* @function		PlayerControlsInit()
* @return		{Controls}
*/
function PlayerControlsInit(gamepadSlot=-1) {
	// Set controls
	if (gamepadSlot >= 0) {
		self.gamepadSlot = gamepadSlot;
		self.controls
			.add("moveLeft", gp_axislh, KeyType.gpAxis, gamepadSlot, -1)
			.addAlt("moveLeft", gp_padl, KeyType.gamepad, gamepadSlot)
			.add("moveRight", gp_axislh, KeyType.gpAxis, gamepadSlot, 1)
			.addAlt("movRight", gp_padr, KeyType.gamepad, gamepadSlot)
			.add("moveUp", gp_axislv, KeyType.gpAxis, gamepadSlot, -1)
			.addAlt("moveUp", gp_padu, KeyType.gamepad, gamepadSlot)
			.add("moveDown", gp_axislv, KeyType.gpAxis, gamepadSlot, 1)
			.addAlt("moveDown", gp_padd, KeyType.gamepad, gamepadSlot)
			.add("dash", gp_shoulderlb, KeyType.gamepad, gamepadSlot)
			.addAlt("dash", gp_shoulderrb, KeyType.gamepad, gamepadSlot)
			.add("sprint", gp_shoulderl, KeyType.gamepad, gamepadSlot)
			.add("backOut", gp_select, KeyType.gamepad, gamepadSlot);
	} else {
		self.controls
			.add("moveLeft", ord("A"))
			.addAlt("moveLeft", vk_left)
			.add("moveRight", ord("D"))
			.addAlt("moveRight", vk_right)
			.add("moveUp", ord("W"))
			.addAlt("moveUp", vk_up)
			.add("moveDown", ord("S"))
			.addAlt("moveDown", vk_down)
			.add("dash", ord("E"))
			.addAlt("dash", ord("Q"))
			.add("sprint", vk_shift)
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

	self._direction = point_direction(0, 0, rk - lk, dk - uk);

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
