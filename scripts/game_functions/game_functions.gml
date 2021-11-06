/**
* Spawn a new player object. Returns player id
*
* @function		spawn_player()
* @return		{real}
*/
function spawn_player(class=oClassDefault) {
	var player = noone;
	if (instance_exists(oSpawnPoint)) {
		// Find spawn point
		var spNum = instance_number(oSpawnPoint);
		var sp = instance_find(oSpawnPoint, irandom(spNum - 1));
		player = instance_create_layer(sp.x, sp.y, "Instances", class)

		// Destroy spawnpoint object
		instance_destroy(sp);
	} else {
		// If no spawnpoints exist, spawn players near the center of the room
		player = instance_create_layer(
			(room_width / 2) + (irandom_range(-5, 5) * 8),
			room_height / 2,
			"Instances",
			oPlayer
		)
	}
	global.players.push(player);

	return player;
}

/**
* Clean up everything related to a player object
*
* @function		cleanup_player(player)
* @param		{object}	player			Player object to remove
* @return		{real}
*/
function cleanup_player(player) {
	// Clean up global variables of player
	global.players.remove(global.players.indexOf(player.id));

	// Reset camera
	global.camera.remove();

	// Set playing to false
	if (player.gamepadSlot >= 0) {
		global.controllers.value[player.gamepadSlot].setPlaying(false);
	} else {
		global.keyboard = false;
	}

	global.playing -= 1;
}
