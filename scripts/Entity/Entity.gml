/**
* Initiate Animations for entity
*
* @function		EntityAnimationsInit()
* @return		{AnimationEngine}
* @see			EntityAnimationTemplateCopy
*/
function EntityAnimationsInit() {
	self.animationsCopy(global._EntityBaseAnimationTemplate);
	return self.animations;
}

/**
* Deep copies template to remove struct pointers
*
* @function		EntityAnimationTemplateCopy(template)
* @param		{AnimationEngine}	template	AnimationEngine template to copy Animations from
* @return		{AnimationEngine}
* @see			Animation, Frame
* @see			variable_struct_get_names, variable_struct_set, array_length, struct_copy
* @TODO			Replace this with AnimationEngineCopy function
*/
function EntityAnimationTemplateCopy(_template) {
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
		variable_struct_set(self.animations.value, _keys[i], new Animation(_displayName, _endType))

		// Get array of animation frames
		var _frames = _templateAnim.value;

		// Get current animation struct writing to
		var _selfAnimation = self.animations.value[$ _keys[i]]

		for(var j = 0; j < array_length(_frames); j++) {
			// Add Frame to Animation Array to prepare to overwrite keys
			_selfAnimation.push(new Frame(sEntityBase, 0));
			// Copy values from template frames into frames of Animation
			struct_copy(_selfAnimation.value[j], _frames[j]);
		}
	}

	return self.animations;
}

/**
* Update entities movement
*
* @function		EntityUpdateMovement()
* @return		{self}
*/
function EntityUpdateMovement() {
	// Set friction
	var f = self._friction;
	var surf = collision_point(x, y, oSurface, 0, 1);
	if (surf) {	
		f = surf._friction;
	}

	// Get x and y acceleration
	self._directionGoal = point_direction(self._currentXSpeed, self._currentYSpeed, self._xSpeedGoal, self._ySpeedGoal);
	self._xAcceleration = lengthdir_x((self._acceleration * f), self._directionGoal);
	self._yAcceleration = lengthdir_y((self._acceleration * f), self._directionGoal);

	// Update current x and y move speeds
	self._currentXSpeed = approach(self._currentXSpeed, self._xSpeedGoal, self._xAcceleration);
	self._currentYSpeed = approach(self._currentYSpeed, self._ySpeedGoal, self._yAcceleration);

	return self;
}
