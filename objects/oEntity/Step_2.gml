// Catch current x and y for next frame
_lastX = x;
_lastY = y;

// Add move speed and external forces together
_xSpeed = _currentXSpeed + _xForce;
_ySpeed = _currentYSpeed + _yForce;

xTo = x + _xSpeed;
yTo = y + _ySpeed;

if (collision_point(xTo, y, oWall, 0, 1)) {
	xTo = x;
}

if (collision_point(xTo, yTo, oWall, 0, 1)) {
	yTo = y;
}

// Update player position
x = xTo;
y = yTo;