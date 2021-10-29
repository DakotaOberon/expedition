// Init values
global.playing = 0;
global.controllers = new Array();

// Loop over each possible controller slot
for(var i = 0; i < 12; i++) {
	// Push a new gamepad to that slot
	global.controllers.push(new Gamepad(i, false, false));
	// Check if a gamepad is connected to that slot
	global.controllers.value[i].check();
}