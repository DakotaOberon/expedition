randomize();

// This is currently all temporary
// Logic is good, just needs to be organized

//// Create players on spawnpoints
// Create player Array
global.players = new Array();

//// Camera
global.camera = new CameraEngine();

global.camera.init(global.players);

// Set fullscreen
window_set_fullscreen(true);

display_set_gui_size(room_width, room_height);