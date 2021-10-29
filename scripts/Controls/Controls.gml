/**
* Controls constructor
*
* @function		Controls()
*/
function Controls() constructor {
	add = ControlsAdd;
	change = ControlsChange;
	check = ControlsCheck;
	checkPress = ControlsCheckPress;
}

/**
* Add a Key to the Controls
*
* @function		ControlsAdd(name, key, [type], [gamepad])
* @param		{any}		name		Name of struct accessor
* @param		{key}		key			Button identifier
* @param		{enum}		[type]		KeyType of control
* @param		{real}		[gamepad]	Gamepad slot to assign controls too
* @return		{self}
* @see			KeyType
*/
function ControlsAdd(_name, _key, _type=KeyType.keyboard, _gamepad=noone) {
	// Create array of forbidden names
	var FORBIDDENNAMES = new Array(["add", "change", "check"]);
	
	// Check if name is a forbidden name
	if (FORBIDDENNAMES.indexOf(_name) == noone) {
		variable_struct_set(self, _name, new Key(_key, _type, _gamepad));
	}
	delete FORBIDDENNAMES;

	return self;
}

/**
* Change a current control
*
* @function		ControlsChange(name, key, [type], [gamepad])
* @param		{any}		name		Name of control to change
* @param		{key}		key			Button identifier
* @param		{enum}		[type]		KeyType of control
* @param		{real}		[gamepad]	Gamepad slot to assign controls too
* @return		{self}
*/
function ControlsChange(_name, _newKey, _type=KeyType.keyboard, _gamepad=noone) {
	var keyStruct = self[$ _name];
	keyStruct.key = _newKey;
	keyStruct.type = _type;
	keyStruct.gamepad = _gamepad;

	return self;
}

/**
* Check if a control is being held
*
* @function		ControlsCheck(name)
* @param		{any}		name		Name of control to check
* @return		{boolean}
*/
function ControlsCheck(_name) {
	var _key = self[$ _name];
	switch (_key.type) {
		case KeyType.keyboard:
			return keyboard_check(_key.key);
		case KeyType.mouse:
			return mouse_check_button(_key.key);
		case KeyType.gamepad:
			return gamepad_button_check(_key.gamepad, _key.key);
	}
}

/**
* Check if a control has been pressed this frame
*
* @function		ControlsCheckPress(name)
* @param		{any}		name		Name of control to check
* @return		{boolean}
*/
function ControlsCheckPress(_name) {
	var _key = self[$ _name];
	switch (_key.type) {
		case KeyType.keyboard:
			return keyboard_check_pressed(_key.key);
		case KeyType.mouse:
			return mouse_check_button_pressed(_key.key);
		case KeyType.gamepad:
			return gamepad_button_check_pressed(_key.gamepad, _key.key);
	}
}

/**
* Key constructor
*
* @function		Key(key, [type], [gamepad])
* @param		{real}		key				Button identifier
* @param		{enum}		[type]			Type of button
* @param		{real}		[gamepad]		Slot of gamepad
* @return		{boolean}
*/
function Key(_key, _type=KeyType.keyboard, _gamepad=noone) constructor {
	key = _key;
	type = _type;
	gamepad = _gamepad;
}

enum KeyType {
	mouse,
	keyboard,
	gamepad
}
