/**
* AnimationEngine controls all things related to animations of an object
*
* @function		AnimationEngine()
* @return		AnimationEngine Struct
*/
function AnimationEngine() constructor {
	value = {};
	addAnimation = AnimationEngineAddAnimation;
	updateAll = AnimationEngineUpdateAll;
	copy = AnimationEngineCopy;
}

/**
* Deep copies template to remove struct pointers
*
* @function		EntityAnimationTemplateCopy(template)
* @param		{AnimationEngine}	template	AnimationEngine template to copy Animations from
* @return		{AnimationEngine}
* @see			Animation, Frame
* @see			variable_struct_get_names, variable_struct_set, array_length, struct_copy
*/
function AnimationEngineCopy(_template) {
	// Get all Animation keys from template AnimationEngine
	var _keys = variable_struct_get_names(_template.value);

	// Loop over each Animation
	for(var i = 0; i < array_length(_keys); i++) {
		var _templateAnim = _template.value[$ _keys[i]];

		// Get Animation DisplayName to pass in as parameter
		var _displayName = _templateAnim.name;

		// Get Animation EndType to pass in as parameter
		var _endType = _templateAnim.endType;

		// Set to blank animation to make it easier to add new frames
		variable_struct_set(self.value, _keys[i], new Animation(_displayName, _endType))

		// Get array of animation frames
		var _frames = _templateAnim.value;

		// Get current animation struct writing to
		var _selfAnimation = self.value[$ _keys[i]]

		for(var j = 0; j < array_length(_frames); j++) {
			// Add Frame to Animation Array to prepare to overwrite keys
			_selfAnimation.push(new Frame(sEntityBase, 0));
			// Copy values from template frames into frames of Animation
			struct_copy(_selfAnimation.value[j], _frames[j]);
		}
	}

	return self;
}

/**
* Add an Animation to the AnimationEngine
*
* @function		AnimationEngineAddAnimation(animationName, [displayName])
* @param		{any}		animationName	Key value of animation
* @param		{string}	displayName		Display string of Animation struct
* @return		{Animation}
*/
function AnimationEngineAddAnimation(_animationName, displayName=_animationName) {
	// Create new Animation object at key _animationName
	self.value[$ _animationName] = new Animation(displayName);

	// Return created Animation
	return self.value[$ _animationName];
}

/*
* Update value for each Frame in each Animation inside AnimationEngine
*
* @function		AnimationEngineUpdateAll(key, val)
* @param		{any}		key				Key of item to change
* @param		{any}		val				New value
* @return		{self}
*/
function AnimationEngineUpdateAll(_key, _val) {
	// Get names of each Animation of AnimationEngine
	var _animations = variable_struct_get_names(self.value);

	// Loop over each Animation
	for(var i = 0; i < array_length(_animations); i++) {
		// Get array of Frame structs
		var _frames = self.value[$ _animations[i]].value;

		// Loop over each Frame in array and set key to value
		for(var j = 0; j < array_length(_frames); j++) {
			switch (_key) {
				case "spriteIndex":
					_frames[j].spriteIndex = _val;
					break;
				case "subImg":
					_frames[j].subImg = _val;
					break;
				case "length":
					_frames[j].length = _val;
					break;
				case "flip":
					_frames[j].flip = _val;
					break;
				case "xOffset":
					_frames[j].xOffset = _val;
					break;
				case "yOffset":
					_frames[j].yOffset = _val;
					break;
				case "color":
					_frames[j].color = _val;
					break;
			}
		}
	}
	return self;
}

/*
* Animation contructor
*
* @function		Animation(animationName, [endType])
* @param		{any}		animationName	Key name of animation
* @param		{enum}		[endType]		Animation end type
*/
function Animation(_animationName, _endType=AnimationEndType.loop) : Array() constructor {
	// Variables
	name = _animationName;
	endType = _endType;
	currentFrame = 0;
	frameTimer = -1;

	// Functions
	setEndType = AnimationSetEndType;
	addFrame = AnimationAddFrame;
	draw = AnimationDraw;
	frameStep = AnimationFrameStep;

	// To String
	toString = function() {
		return string_upper(self.name);
	}
}

/*
* Set end type of an Animation
*
* @function		AnimationSetEndType(endType)
* @param		{enum}		endType			Animation end type
* @return		{set}
*/
function AnimationSetEndType(_endType) {
	self.endType = _endType;
}

/*
* Add frame to animation array
*
* @function		AnimationAddFrame(sprIndex, subImg, [length], [flip], [xOffset], [yOffset], [color])
* @param		{sprite}	spriteIndex		Sprite to draw for animation
* @param		{real}		subImg			Sub image to draw
* @param		{real}		[length]		How many frames in game to keep frame up
* @param		{enum}		[flip]			Should the sprite be flip vertically
* @param		{real}		[xOffset]		Pixels along the x-axis to shift the frame
* @param		{real}		[yOffset]		Pixels along the y-axis to shift the frame
* @param		{color}		[color]			Color to draw the frame with
* @return		{self}
* @see			Frame
*/
function AnimationAddFrame(_sprIndex, _subImg, _length=1, _flip=FrameFlip.none, _xOffset=0, _yOffset=0, _rotation=0, _color=c_white) {
	// Add frame to animation frame array
	self.push(new Frame(_sprIndex, _subImg, _length, _flip, _xOffset, _yOffset, _rotation, _color));

	// If this is the first frame, set current frame timer to it's length
	if(self.frameTimer = -1) {
		self.frameTimer = _length;
	}
	return self;
}

/*
* Draw Animation to screen
* 
* @function		AnimationDraw(x, y, [alpha], [color], [rotation])
* @param		{real}		x				X coordinate
* @param		{real}		y				Y coordinate
* @param		{real}		[alpha]			Override alpha value
* @param		{color}		[color]			Override color value
* @param		{real}		[rotation]		Override rotation value
* @return		{self}
* @see			Frame
* @see			AnimationFrameStep
*/
function AnimationDraw(_x, _y, _alpha=1, _color=noone, _rotation=noone) {
	// Get current frame
	var frame = self.value[self.currentFrame];

	var xScale = 1;
	var yScale = 1;
	switch (frame.flip) {
		case FrameFlip.xFlip:
			xScale = -1;
		break;
		case FrameFlip.yFlip:
			yScale = -1;
		break;
		case FrameFlip.both:
			xScale = -1;
			yScale = -1;
		break;
	}
	// Set color
	var color = _color? _color : frame.color;

	var rotation = _rotation? _rotation : frame.rotation;

	// Draw sprite to screen
	draw_sprite_ext(frame.spriteIndex, frame.subImg, _x + frame.xOffset, _y + frame.yOffset, xScale, yScale, rotation, color, _alpha);

	return self
}

/*
* Process Animation frame step. Place inside of an objects draw function
*
* @function		AnimationFrameStep([speed])
* @param		{real}		[speed]			Speed to play frame
* @return		{self}
* @see			Frame
*/
function AnimationFrameStep(_speed=1) {
	if (self.frameTimer > 0) {
		// Each frame, decrease frame timer by one
		self.frameTimer -= _speed;
	} else {
		// If frameTimer is less than zero, move to next frame
		self.currentFrame += 1;
		if (self.currentFrame >= self.getLength()) {
			// If it's at the end of the animation frame set
			switch (self.endType) {
				case AnimationEndType.pause:
					// Pause keeps the frame at it's current result
					self.currentFrame -= 1;
					break;
				case AnimationEndType.loop:
					// Loop moves back to the first frame
					self.currentFrame = 0;
					break;
				case AnimationEndType.reverse:
					// Reverse the frame array before continuing from the beginning
					self.currentFrame = 0;
					self.reverse();
					break;
			}
		}

		// Set frameTimer to current frame length
		self.frameTimer = self.value[self.currentFrame].length;
	}
	return self;
}

/*
* Frame contructor
*
* @function		Frame(sprIndex, subImg, [length], [flip], [xOffset], [yOffset], [color])
* @param		{sprite}	spriteIndex		Sprite to draw for animation
* @param		{real}		subImg			Sub image to draw
* @param		{real}		[length]		How many frames in game to keep frame up
* @param		{enum}		[flip]			Should the sprite be flip vertically
* @param		{real}		[xOffset]		Pixels along the x-axis to shift the frame
* @param		{real}		[yOffset]		Pixels along the y-axis to shift the frame
* @param		{color}		[color]			Color to draw the frame with
* @see			AnimationDraw
*/
function Frame(_sprIndex, _subImg, _length=1, _flip=FrameFlip.none, _xOffset=0, _yOffset=0, _rotation=0, _color=c_white) constructor {
	spriteIndex = _sprIndex;
	subImg = _subImg;
	length = _length;
	flip = _flip;
	xOffset = _xOffset;
	yOffset = _yOffset;
	rotation = _rotation;
	color = _color;
}

/*
* Animation End Type enum
*
* @see Animation
* @see AnimationFrameStep
*/
enum AnimationEndType {
	pause,
	loop,
	reverse,
	newAnimation
}

enum FrameFlip {
	none,
	xFlip,
	yFlip,
	both
}