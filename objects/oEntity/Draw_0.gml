// Draw current animation
animations.value[$ currentAnim].draw(x, y);

// Draw statuses
if (status.stun.timer > 0) {
	global._StatusStun.value[$ StatusType.stun].draw(x, y, 0.6);
}

if (_health < _maxHealth) {
	var healthPercentage = (_health / _maxHealth) * 100;
	draw_healthbar(x - 8, y - 17, x + 8, y - 17, healthPercentage, c_black, c_red, c_orange, 0, 1, 1);
}
