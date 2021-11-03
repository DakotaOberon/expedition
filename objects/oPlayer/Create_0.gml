// Inherit the parent event
event_inherited();

// Initiate player
index = instance_number(oPlayer) - 1;
gamepadSlot = -1;
controls = new Controls();

// Player Functions
controlsInit = PlayerControlsInit;
checkAnyMoveKeys = PlayerCheckAnyMoveKeys;
updateDirection = PlayerUpdateDirection;
updateMovement = PlayerUpdateMovement;

camera = noone;

// Set color for testing
animations.updateAll(
	"color",
	make_color_hsv(
		irandom(255),
		irandom_range(110, 220),
		irandom_range(60, 255)
	)
);
