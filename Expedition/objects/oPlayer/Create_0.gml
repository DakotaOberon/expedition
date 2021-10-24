randomize();
// Inherit the parent event
event_inherited();

// Initiate player
player = new Player(1);
player.controlsInit();
player.animationsInit();

// Set color for testing
player.animations.updateAll("color", make_color_hsv(irandom(255), irandom_range(110, 220), irandom_range(60, 255)));
