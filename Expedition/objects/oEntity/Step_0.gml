var xMove, yMove;

// Check if entity moved from last frame
xMove = sign(x - _lastX);
yMove = sign(y - _lastY);

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

// Can't leave room
if (x < 0 || x > room_width) {
	x = _lastX;
}
if (y < 0 || y > room_height) {
	y = _lastY;
}

// Catch current x and y for next frame
_lastX = x;
_lastY = y;

// Set depth
depth = -y;