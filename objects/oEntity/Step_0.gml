var xMove, yMove;

// Check if entity moved from last frame
xMove = sign(x - _lastX);
yMove = sign(y - _lastY);

if (inCombat) {
	if (attackDirection >= 0 && attackDirection <= 45) || (attackDirection >= 315 && attackDirection <= 360) {
		currentAnim = animSet.walkR;
	} else if (attackDirection >= 135 && attackDirection <= 225) {
		currentAnim = animSet.walkL;
	} else if (attackDirection > 45 && attackDirection < 135) {
		currentAnim = animSet.walkU;
	} else {
		currentAnim = animSet.walkD;
	}
} else {
	// Set animation based on movement
	if (xMove == 0 && yMove == 0) {
		currentAnim = animSet.idle;
	} else if (abs(xMove) >= abs(yMove)) {
		if (sign(xMove)) {
			currentAnim = animSet.walkR;
		} else {
			currentAnim = animSet.walkL;
		}
	} else {
		if (sign(yMove)) {
			currentAnim = animSet.walkD;
		} else {
			currentAnim = animSet.walkU;
		}
	}
}

// Can't leave room
if (x < 0 || x > room_width) {
	x = _lastX;
}
if (y < 0 || y > room_height) {
	y = _lastY;
}

// Get current speed
var spd = point_distance(_lastX, _lastY, x, y);

// Increment frame
animations.value[$ currentAnim].frameStep(spd);

// Set depth
depth = -y;

// Status Effects
var effects = variable_struct_get_names(status);
for (var i = 0; i < array_length(effects); i++) {
	// Get status
	var stat = variable_struct_get(status, effects[i]);

	if (stat.timer > 0) {
		// Apply effect
		switch (stat.type) {
			case StatusType.stun:
				_currentXSpeed = 0;
				_currentYSpeed = 0;
				_xSpeedGoal = 0;
				_ySpeedGoal = 0;
			break;
		}

		// Decrement timer
		stat.timer -= 1;
	}
}
