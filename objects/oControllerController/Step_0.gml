// Check if any controller not yet joined has pressed any button to join
	// As long as players is less than 8
if (global.playing < 8) {
		// Loop over each controller slot
	for(var i = 0; i < 12; i++) {
			// Check if any buttons were pressed per controller
		if(gamepad_check_any(i, [gp_select])) {
			var gp = global.controllers.value[i];
				// If controller isn't already playing
			if (gp.playing != true) {
				// Set playing to true on gamepad
				gp.setPlaying(true);
				// Increase playing count by 1
				global.playing += 1;

				// Spawn a player object
				var player = spawn_player();

				// Assign gamepad to player
				player.player.controlsInit(i);

				// Update camera
				global.camera.update(global.players);
			}
		}
	}

	if !(global.keyboard) {
		if (mouse_check_button_pressed(mb_any) || keyboard_check_pressed(vk_anykey)) {
			global.keyboard = true;
			global.playing += 1;
		
			var player = spawn_player();
		
			player.player.controlsInit();
		
			global.camera.update(global.players);
		}
	}
}
