/**
* Spawn a new player object. Returns player id
*
* @function		spawn_player([class])
* @param		{object}	[class]			Player class
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
			class
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

/**
* Clean up everything related to a player object
*
* @function		instance_nearest_notme(x1, y1, obj, _id, [allyTag])
* @param		{real}		x			x origin to check from
* @param		{real}		y			y origin to check from
* @param		{real}		obj			Object to check for
* @param		{real}		id			id of object making the check
* @param		{string}	[allyTag]	Ally tag to avoid
* @return		{real}
*/
function instance_nearest_notme(x1, y1, obj, _id, allyTag=noone) {
	// Get total number of objects
	var n = instance_number(obj);
	// Set initial values
	var nearest = noone;
	var nearDis = 10000000;
	for(var i = 0; i < n; i++) {
		// Loop over each instance
		var inst = instance_find(obj, i);
		if (instance_exists(inst)) {
			// Check not self or ally
			if (inst.id != _id) && (inst.allyTag != allyTag) {
				var instDis = point_distance(inst.x, inst.y, x1, y1);
				// Compare values
				if (instDis < nearDis) {
					nearest = inst;
					nearDis = instDis;
				}
			}
		}
	}

	return nearest;
}

/**
* Used as a function filler
*
* @function		blank()
*/
function blank() {
	
}