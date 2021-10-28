// This is currently all temporary
// Logic is good, just needs to be organized

//// Create players on spawnpoints
// Create player Array
global.players = new Array();

// Set number of players 1-8
// Change this value to play with multiple people
// TODO: Move number of players logic elsewhere
var numberOfPlayers = 2;

for (var i = 0; i < numberOfPlayers; i++) {
	if (instance_exists(oSpawnPoint)) {
		// Find spawn point
		var spNum = instance_number(oSpawnPoint);
		var sp = instance_find(oSpawnPoint, irandom(spNum - 1));

		// Animation issue starts here
		global.players.push(
			instance_create_layer(sp.x, sp.y, "Instances", oPlayer)
		);
		
		// Destroy spawnpoint object
		instance_destroy(sp);
	} else {
		// If no spawnpoints exist, spawn players near the center of the room
		global.players.push(
			instance_create_layer(
				(room_width / 2) + (i * 8),
				room_height / 2,
				"Instances",
				oPlayer
			)
		);
	}
}

//// Camera
camera = new CameraEngine();

camera.init(global.players);

// Set fullscreen
window_set_fullscreen(true);