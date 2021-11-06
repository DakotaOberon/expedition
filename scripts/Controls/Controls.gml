/**
* Controls constructor
*
* @function		Controls()
*/
function Controls() constructor {
	keys = {};
	altKeys = {};
	add = ControlsAdd;
	addAlt = ControlsAddAlt;
	change = ControlsChange;
	check = ControlsCheck;
	checkPress = ControlsCheckPress;
}

/**
* Add a Key to the Controls
*
* @function		ControlsAdd(name, key, [type], [gamepad])
* @param		{any}		name			Name of struct accessor
* @param		{key}		key				Button identifier
* @param		{enum}		[type]			KeyType of control
* @param		{real}		[gamepad]		Gamepad slot to assign controls too
* @param		{real}		[axisDirection]	Direction of axis
* @return		{self}
* @see			KeyType
*/
function ControlsAdd(_name, _key, _type=KeyType.keyboard, _gamepad=noone, _axisDirection=1) {
	variable_struct_set(self.keys, _name, new Key(_key, _type, _gamepad, _axisDirection));

	return self;
}

/**
* Add an Alternate Key to the Controls
*
* @function		ControlsAddAlt(name, key, [type], [gamepad])
* @param		{any}		name			Name of struct accessor
* @param		{key}		key				Button identifier
* @param		{enum}		[type]			KeyType of control
* @param		{real}		[gamepad]		Gamepad slot to assign controls too
* @param		{real}		[axisDirection]	Direction of axis
* @return		{self}
* @see			KeyType
*/
function ControlsAddAlt(_name, _key, _type=KeyType.keyboard, _gamepad=noone, _axisDirection=1) {
	variable_struct_set(self.altKeys, _name, new Key(_key, _type, _gamepad, _axisDirection));

	return self;
}

/**
* Change a current control
*
* @function		ControlsChange(name, key, [alt], [type], [gamepad])
* @param		{any}		name			Name of control to change
* @param		{key}		key				Button identifier
* @param		{boolean}	alt				Is this an alternate
* @param		{enum}		[type]			KeyType of control
* @param		{real}		[gamepad]		Gamepad slot to assign controls too
* @return		{self}
*/
function ControlsChange(_name, _newKey, _alt=false, _type=noone, _gamepad=noone) {
	if (_alt) {
		var keyStruct = self.altKeys[$ _name];
	} else {
		var keyStruct = self.keys[$ _name];
	}

	keyStruct.key = _newKey;
	keyStruct.type = _type? _type : keyStruct.type;
	keyStruct.gamepad = _gamepad? _gamepad : keyStruct.gamepad;

	return self;
}

/**
* Check if a control is being held
*
* @function		ControlsCheck(name)
* @param		{any}		name			Name of control to check
* @return		{boolean}
*/
function ControlsCheck(_name) {
	// Set default return
	var returnVal = 0;

	// Get Primary key
	var _key = self.keys[$ _name];
	switch (_key.type) {
		case KeyType.keyboard:
			returnVal = keyboard_check(_key.key);
		break;
		case KeyType.mouse:
			returnVal = mouse_check_button(_key.key);
		break;
		case KeyType.gamepad:
			returnVal = gamepad_button_check(_key.gamepad, _key.key);
		break;
		case KeyType.gpAxis:
			returnVal = gamepad_check_axis_strict(_key.gamepad, _key.key, _key.axisDirection);
		break;
	}

	if (returnVal == 0) {
		if (variable_struct_exists(self.altKeys, _name)) {
			// Get Alternate key
			var _altKey = self.altKeys[$ _name];
			switch (_altKey.type) {
				case KeyType.keyboard:
					return keyboard_check(_altKey.key);
				case KeyType.mouse:
					return mouse_check_button(_altKey.key);
				case KeyType.gamepad:
					return gamepad_button_check(_altKey.gamepad, _altKey.key);
				case KeyType.gpAxis:
					return gamepad_check_axis_strict(_altKey.gamepad, _altKey.key, _altKey.axisDirection);
			}
		}
	}

	return returnVal;
}

/**
* Check if a control has been pressed this frame
*
* @function		ControlsCheckPress(name)
* @param		{any}		name			Name of control to check
* @return		{boolean}
*/
function ControlsCheckPress(_name) {
	var _key = self.keys[$ _name];
	switch (_key.type) {
		case KeyType.keyboard:
			return keyboard_check_pressed(_key.key);
		case KeyType.mouse:
			return mouse_check_button_pressed(_key.key);
		case KeyType.gamepad:
			return gamepad_button_check_pressed(_key.gamepad, _key.key)
		case KeyType.gpAxis:
			return gamepad_check_axis_strict(_key.gamepad, _key.key, _key.axisDirection);
	}
	
	if (variable_struct_exists(self.altKeys, _name)) {
		var _altKey = self.altKeys[$ _name];
		switch (_altKey.type) {
			case KeyType.keyboard:
				return keyboard_check_pressed(_altKey.key);
			case KeyType.mouse:
				return mouse_check_button_pressed(_altKey.key);
			case KeyType.gamepad:
				return gamepad_button_check_pressed(_altKey.gamepad, _altKey.key);
			case KeyType.gpAxis:
				return gamepad_check_axis_strict(_altKey.gamepad, _altKey.key, _altKey.axisDirection);
		}
	}
}

/**
* Key constructor
*
* @function		Key(key, [type], [gamepad], [axisDirection])
* @param		{real}		key				Button identifier
* @param		{enum}		[type]			Type of button
* @param		{real}		[gamepad]		Slot of gamepad
* @param		{real}		[axisDirection]	Direction of axis
* @return		{boolean}
*/
function Key(_key, _type=KeyType.keyboard, _gamepad=noone, _axisDirection=1) constructor {
	key = _key;
	type = _type;
	gamepad = _gamepad;
	axisDirection = _axisDirection;
}

enum KeyType {
	mouse,
	keyboard,
	gamepad,
	gpAxis
}
