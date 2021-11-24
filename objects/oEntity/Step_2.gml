// Catch current x and y for next frame
_lastX = x;
_lastY = y;

_xSpeed = _currentXSpeed + _xForce;
_ySpeed = _currentYSpeed + _yForce;

xTo = x + _xSpeed;
yTo = y + _ySpeed;

if (collision_point(xTo, y, oWall, 0, 1)) {
	_currentXSpeed = 0;
	xTo = x;
}

if (collision_point(xTo, yTo, oWall, 0, 1)) {
	_currentYSpeed = 0;
	yTo = y;
}

// Update player position
x = xTo;
y = yTo;

_xForce = 0;
_yForce = 0;

// Reduce invincible timer
if (invincibleTimer > 0) {
	invincibleTimer -= 1;
}

// Check for damage taken
if (tookDamage) {
	var dn = instance_create_layer(x, y, "Hitbox", oDamageNumber)
	dn.damage = damageTook;
	dn.crit = false;

	lastTookDamage = 0;
	lastDamageTook = damageTook;
	tookDamage = false;
}

// Increment combat values
lastTookDamage += 1;

// Death
if (_health <= 0) {
	instance_destroy();
}

