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
