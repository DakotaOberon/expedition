// Run step scripts from Player
player.updateDirection();
player.updateMovement(moveSpeed);

// Update player position
x += player._xSpeed;
y += player._ySpeed;

// Inherit the parent event
event_inherited();

// Temporary for testing
if (keyboard_check_pressed(vk_escape)) {
	game_restart();
}
