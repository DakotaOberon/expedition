// Run step scripts from Player
player.updateDirection();
player.updateMovement(moveSpeed);

// Update player position
x += player._xSpeed;
y += player._ySpeed;

// Inherit the parent event
event_inherited();

// Increment frame
player.animations.value[$ currentAnim].frameStep();
