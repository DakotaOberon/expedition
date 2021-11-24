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
//updateMovement = PlayerUpdateMovement;

camera = noone;

allyTag = AllyTag.friendly;

moveSpeed = 1.25;
