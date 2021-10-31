/**
* CameraEngine constructor
*
* @function		CameraEngine()
*/
function CameraEngine() constructor {
	cameras = new Array();
	init = CameraEngineInit;
	update = CameraEngineUpdate;
	remove = CameraEngineRemove;
	reset = CameraEngineReset;
	step = CameraEngineStep;
}

/**
* Initiate Camera Engine
*
* @function		CameraEngineInit(players)
* @param		{real}		players			Total number of players
* @see			CameraEngine, Camera, CameraInit
*/
function CameraEngineInit(players) {
	var numberOfCameras = players.getLength();

	var camIndex = 0;
	repeat (numberOfCameras) {
		// Push new Camera struct to CameraEngine array
		var currCam = self.cameras.push(new Camera(camIndex, players.value[camIndex])).value[camIndex];

		camera_engine_create_camera(currCam, numberOfCameras, camIndex);
		camIndex += 1;
	}
}

/**
* Creates a new camera for the screen
*
* @function		camera_engine_create_camera(camera, numberOfCameras, index)
* @param		{Camera}	camera			Camera struct to alter
* @param		{real}		numberOfCameras Total cameras on screen, used in calculations
* @param		{real}		index			Camera slot
* @see			CameraInit, window_set_size, surface_resize
*/
function camera_engine_create_camera(camera, numberOfCameras, index) {
	// Hard-coded camera width and height
		// Eventually this should be set by aspect ratio in settings
	var width = 1920;
	var height = 1080;

	// Camera variables
		// Postion of camera
	var camX = 0;
	var camY = 0;
		// Size of camera on screen
	var camWidth = width;
	var camHeight = height;
		// Aspect ratio of veiw
	var camRatioW = 16;
	var camRatioH = 9;

	if (numberOfCameras > 1) {
			// Get rows and columns
		var rows = ceil(numberOfCameras / 3);
		var cols = ceil(numberOfCameras / 4) + 1;
			// Get size of camera on screen
		camWidth = (width / cols);
		camHeight = (height / rows);
			// Move camera based on camera index
		camX = (camWidth * (index % cols));
		camY = (camHeight * floor(index / cols));
	}

	// Adjust ratio
	switch (numberOfCameras) {
		case 2:
			camRatioH = 18;
			break;
		case 5:
		case 6:
			camRatioH = 13.5;
			break;
	}

	// Initiate camera
	camera.init(camX, camY, camWidth, camHeight, camRatioW, camRatioH);

	// Set window size and application surface to aspect ratio
	window_set_size(width, height);
	surface_resize(application_surface, width, height);
}

/**
* Update CameraEngine based on players Array
*
* @function		CameraEngineUpdate(players)
* @param		{Array}		players			Array of players that need cameras
* @see			camera_engine_create_camera
*/
function CameraEngineUpdate(players) {
	var numberOfCameras = players.getLength();

	var camIndex = 0;
	repeat (numberOfCameras) {
		var currCam = noone;

		if (camIndex >= self.cameras.getLength()) {
			// Push new Camera struct to CameraEngine array
			currCam = self.cameras.push(new Camera(camIndex, players.value[camIndex])).value[camIndex];
		} else {
			currCam = self.cameras.value[camIndex];
		}

		camera_engine_create_camera(currCam, numberOfCameras, camIndex);
		camIndex += 1;
	}
}

/**
* Remove a Camera from CameraEngine, recalculate cameras
*
* @function		CameraEngineRemove()
* @see			CameraEngineReset, CameraEngineUpdate
*/
function CameraEngineRemove() {
	self.reset()
		.update(global.players);

	return self;
}

/**
* Removes all Cameras from CameraEngine, and resets GameMaker camera and view values
*
* @function		CameraEngineReset()
* @see			camera_destroy
*/
function CameraEngineReset() {
	for (var i = 0; i < self.cameras.getLength(); i++) {
		var cam = self.cameras.value[i];
		
		// Reset GameMaker values
		camera_destroy(cam.camera);
		view_visible[cam.view] = false;
	}
	
	// Delete cameras Array struct and create a blank one
	delete self.cameras;
	self.cameras = new Array();

	return self;
}

function CameraEngineStep() {
	for (var i = 0; i < self.cameras.getLength(); i++) {
		self.cameras.value[i].step();
	}
}

/**
* Camera constructor
*
* @function		Camera([follow]);
* @param		{object}	[follow]		Which object to follow
*/
function Camera(_number, _follow=noone) constructor {
	follow = _follow;
	camera = noone;
	view = _number;

	init = CameraInit;
	step = CameraStep;
}

/**
* Initiate Camera
*
* @function		CameraInit(_x, _y, width, height, [wRatio], [hRatio])
* @param		{real}		_x				x position of camera in relation to screen
* @param		{real}		_y				y position of camera in relation to screen
* @param		{real}		width			Width of camera on screen
* @param		{real}		height			Height of camera on screen
* @param		{real}		[wRatio]		Horizontal aspect ratio
* @param		{real}		[hRatio]		Vertical aspect ratio
* @see			camera_create_view, view_visible
*/
function CameraInit(_x, _y, width, height, wRatio = 16, hRatio = 9) {
	// Set camera
	self.camera = camera_create_view(
		self.follow.x,
		self.follow.y,
		20 * wRatio, // 320
		20 * hRatio, // 240
		0,
		noone,
		-1,
		-1,
		width,
		height
	)

	// Set camera to view index
	view_set_camera(self.view, self.camera);

	// Set view properties
	view_visible[self.view] = true;
	view_xport[self.view] = _x;
	view_yport[self.view] = _y;
	view_wport[self.view] = width;
	view_hport[self.view] = height;

	self.follow.camera = self;
}

/**
* Camera position step
*
* @function		CameraStep([direction], [distance])
* @param		{real}		[direction]		Direction to adjust camera (Not yet implemented)
* @param		{real}		[distance]		Distance from player to move camera (Not yet implemented)
* @see			camera_set_view_pos
*/
function CameraStep(_direction=-1, _distance=0) {
	var _speed = 15;
	var _w = camera_get_view_width(self.camera);
	var _h = camera_get_view_height(self.camera);
	var _x = camera_get_view_x(self.camera);
	var _y = camera_get_view_y(self.camera);
	var _offSet = clamp(60 * (_distance / 100), 0, 60);
	var xAdd = lengthdir_x(_offSet, _direction);
	var yAdd = lengthdir_y(_offSet, _direction);

	// Get camera position if exactly on player
	var xTo = self.follow.x - (_w / 2) + xAdd;
	var yTo = self.follow.y - (_h / 2) + yAdd;

	// Get difference between actual position and target position
	var xDiff = _x - xTo;
	var yDiff = _y - yTo;

	// Get value between both positions based on _speed
	var xFinal = (_x - (xDiff / _speed));
	var yFinal = (_y - (yDiff / _speed));

	// Set camera position
	camera_set_view_pos(self.camera, xFinal, yFinal);
}
