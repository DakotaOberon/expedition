/**
* Get the current friction of an entity
*
* @function		get_friction([id])
* @param		{real}		[id]			Object to check. Default is object calling function
* @return		{real}
*/
function get_friction(_id=self) {
	var f = _id._friction;
	var surf = collision_point(_id.x, _id.y, oSurface, 0, 1);
	if (surf) {
		f = surf._friction;
	}
	
	return f;
}

/**
* Update entity ai movement values
*
* @function		ai_update_movement(distance, [id])
* @param		{real}		distance		Distance to target location
* @param		{real}		[id]			Object to check. Default is object calling function
* @return		{real}
*/
function ai_update_movement(distance, _id=self) {
	var currSpd = point_distance(_id.x, _id.y, _id.x + _id._currentXSpeed, _id.y + _id._currentYSpeed);

	var f = get_friction(_id);

	var tempStopDistance = sigma(0, currSpd, _id._acceleration * f);
	_id.stopDistance = max(tempStopDistance, _id.stopDistance);

	if (distance <= _id.stopDistance) {
		_id._xSpeedGoal = 0;
		_id._ySpeedGoal = 0;
	} else {
		// Clamp to moveSpeed
		distance = clamp(distance, 0, _id.moveSpeed);
		// Set x and y speed goals
		_id._xSpeedGoal = lengthdir_x(distance, _id._direction);
		_id._ySpeedGoal = lengthdir_y(distance, _id._direction);
	}
}