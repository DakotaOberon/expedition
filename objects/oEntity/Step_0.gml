var xMove, yMove;

// Check if entity moved from last frame
xMove = sign(x - _lastX);
yMove = sign(y - _lastY);

updateMovement();

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

	switch(stat.type) {
		case StatusType.knockback:
			// Apply knockback force
			var kbArray = status.knockback.values;

			// Decrement so it's safe to remove items
			for(var j = kbArray.getLength(); j > 0; j--) {
				var stat = kbArray.value[j - 1];
				if (stat.length <= 0) {
					kbArray.remove(j - 1);
					continue;
				}

				_xForce += lengthdir_x(stat.strength, stat._direction);
				_yForce += lengthdir_y(stat.strength, stat._direction);

				// Decrease length
				stat.length -= 1;
			}
		break;
		case StatusType.stun:
			if (stat.timer > 0) {
				// Apply effect
				_currentXSpeed = 0;
				_currentYSpeed = 0;
				_xSpeedGoal = 0;
				_ySpeedGoal = 0;

				// Run stun function
				status.stun.run();
				// Decrement timer
				stat.timer -= 1;
			}
		break;
	}
}
