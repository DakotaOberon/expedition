// Draw current animation
animations.value[$ currentAnim].draw(x, y);

// Draw statuses
if (status.stun.timer > 0) {
	global._StatusStun.value[$ StatusType.stun].draw(x, y, 0.6);
}
