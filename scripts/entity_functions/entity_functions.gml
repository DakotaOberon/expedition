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
* @return		{object}
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

	return _id;
}

/**
* Check for collisions within bbox
* 
* @function		collision_on_me([xOffset], [yOffset], [walls])
* @param		{real}		[xOffset]		x Offset to check at
* @param		{real}		[yOffset]		y Offset to check at
* @param		{boolean}	[walls]			Check for walls
* @return		{Array}
*/
function collision_on_me(xOffset=0, yOffset=0, walls=false) {
	var tmpDS = ds_list_create();
	collision_rectangle_list(
		self.bbox_left + xOffset,
		self.bbox_top + yOffset,
		self.bbox_right + xOffset,
		self.bbox_bottom + yOffset,
		oEntity,
		false,
		true,
		tmpDS,
		false
	);

	if (walls) {
		collision_rectangle_list(
			self.bbox_left + xOffset,
			self.bbox_top + yOffset,
			self.bbox_right + xOffset,
			self.bbox_bottom + yOffset,
			oWall,
			false,
			true,
			tmpDS,
			false
		);
	}

	var returnArray = new Array();

	for(var i = 0; i < ds_list_size(tmpDS); i++) {
		returnArray.push(tmpDS[| i]);
	}

	return returnArray;
}

/**
* Get exact distance to enemy bbox from self
* 
* @function		entity_distance(target)
* @param		{target}	target			Object to check for
* @return		{real}
*/
function entity_distance(target) {
	var ptX1 = target.bbox_left;
	var ptX2 = target.bbox_right;
	var ptY1 = target.bbox_top;
	var ptY2 = target.bbox_bottom;

	var d1 = point_distance(x, y, ptX1, ptY1);
	var d2 = point_distance(x, y, ptX2, ptY1);
	var d3 = point_distance(x, y, ptX1, ptY2);
	var d4 = point_distance(x, y, ptX2, ptY2);

	return min(d1, d2, d3, d4);
}

enum WeaponLocation {
	back
}

/**
* Draw Weapon at beginning of draw step on Entity
* 
* @function		draw_weapon_start([location])
* @param		{enum}		[location]		Location to draw weapon
* @return
*/
function draw_weapon_start(location=WeaponLocation.back) {
	var drawWeapon = false;
	var weaponYOffset = 0;
	var weaponXOffset = 0;
	var xFlip = 1;
	var weaponRotation = 0;
	switch (location) {
		case WeaponLocation.back:
			// Draw weapon on back
			weaponYOffset = -14;
			weaponXOffset = 8;
			weaponRotation = 180;
			switch (currentAnim) {
				case animSet.walkR:
					xFlip = -1;
				case animSet.walkL:
				case animSet.walkD:
					drawWeapon = true;
				break;
			}
		break;
	}

	if (drawWeapon) {
		draw_sprite_ext(weapon, 0, x + (weaponXOffset * xFlip), y + weaponYOffset, xFlip, 1, weaponRotation, c_white, 1);
	}
}

/**
* Draw Weapon at end of draw step on Entity
* 
* @function		draw_weapon_end([location])
* @param		{enum}		[location]		Location to draw weapon
* @return
*/
function draw_weapon_end(location=WeaponLocation.back) {
	var drawWeapon = false;
	var weaponYOffset = 0;
	var weaponXOffset = 0;
	var xFlip = 1;
	var weaponRotation = 0;

	switch (location) {
		case WeaponLocation.back:
			// Draw weapon on back
			weaponYOffset = -14;
			weaponXOffset = 8;
			weaponRotation = 180;
			switch (currentAnim) {
				case animSet.walkU:
					xFlip = -1;
					drawWeapon = true;
				break;
			}
		break;
	}

	if (drawWeapon) {
		draw_sprite_ext(weapon, 0, x + (weaponXOffset * xFlip), y + weaponYOffset, xFlip, 1, weaponRotation, c_white, 1);
	}
}
