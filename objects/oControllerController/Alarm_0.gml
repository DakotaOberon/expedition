/// @description Check disconnects and reconnects

// Loop over each possible controller slot
for(var i = 0; i < 12; i++) {
	var gp = controllers.value[i];
	
	// Check if playing
	if (gp.playing) {
		// Set connection status
		gp.check();
		
		if (!gp.connected) {
			log("Gamepad", i, "disconnected");
		}
	}
}

alarm[0] = 60 * 5 // 5 seconds