// Run step scripts from Player
player.updateDirection();
player.updateMovement(moveSpeed);

// Check for backOut button being pressed
if (player.controls.checkPress("backOut")) {
	// Clean up global variables of player
	global.players.remove(global.players.indexOf(id));

	// Reset camera
	global.camera.remove();

	// Set playing to false
	var gpSlot = player.gamepad;
	if (gpSlot >= 0) {
		global.controllers.value[gpSlot].setPlaying(false);
	}
	global.playing -= 1;

	// Destory this object
	instance_destroy(self);
}

var lastX = x;
var lastY = y;

// Update player position
x += player._xSpeed;
y += player._ySpeed;

// Inherit the parent event
event_inherited();

var spd = point_distance(lastX, lastY, x, y);

// Increment frame
player.animations.value[$ currentAnim].frameStep(spd);
