/**
* Player constructor
*
* @function		Player(player)
* @param		{real}		player			Identify which player slot it is for
* @see			Controls
*/
function Player(_player) : Entity() constructor {
	player = _player;
	gamepad = -1;
	controls = new Controls();
	controlsInit = PlayerControlsInit;

	checkAnyMoveKeys = PlayerCheckAnyMoveKeys;

	updateDirection = PlayerUpdateDirection;
	updateMovement = PlayerUpdateMovement;
}

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
		self.gamepad = gamepadSlot;
		self.controls
			.add("moveLeft", noone)
			.add("moveRight", noone)
			.add("moveUp", noone)
			.add("moveDown", noone)
			.add("backOut", gp_select, KeyType.gamepad, gamepadSlot);
	} else {
		self.controls
			.add("moveLeft", ord("A"))
			.add("moveRight", ord("D"))
			.add("moveUp", ord("W"))
			.add("moveDown", ord("S"))
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
	var lk = self.controls.check("moveLeft")
	var rk = self.controls.check("moveRight")
	var uk = self.controls.check("moveUp")
	var dk = self.controls.check("moveDown")

	self._direction = point_direction(0, 0, rk - lk, dk - uk);

	return self;
}


/**
* Update players direction value
*
* @function		PlayerUpdateMovement(speed)
* @param		{real}		speed			Players current movement speed
* @return		{self}
*/
function PlayerUpdateMovement(_speed) {
	self._xSpeed = 0;
	self._ySpeed = 0;
	if (self.gamepad >= 0) {
		self._xSpeed = (_speed * gamepad_axis_value(self.gamepad, gp_axislh));
		self._ySpeed = (_speed * gamepad_axis_value(self.gamepad, gp_axislv));
	} else if (self.checkAnyMoveKeys()) {
		self._xSpeed = lengthdir_x(_speed, self._direction);
		self._ySpeed = lengthdir_y(_speed, self._direction);
	}

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
