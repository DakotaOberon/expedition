/**
* Checks if any buttons on a gamepad is being pressed and returns which button
*
* @function		gamepad_check_any([slot], [dontCheck])
* @param		{real}		[slot]			Gamepad slot to check
* @param		{array}		[dontCheck]		Array of buttons to skip over
* @return		{real}
* @see			gamepad_button_check
*/
function gamepad_check_any(_slot=0, _dontCheck=[]) {
	// Loop over each possible gp button
	for (var i = gp_face1; i <= gp_axisrv; i++ ) {

		// Check if button is being pressed
		if (gamepad_button_check(_slot, i)) {
			if (array_length(_dontCheck)) {
				var dontCheckArray = new Array(_dontCheck);
				// Keep going if button is in dontCheckArray
				if !(dontCheckArray.indexOf(i) >= 0) {
					// Return button pressed
					return i;
				}
			} else {
				// Return button pressed
				return i;
			}
		}
	}
	return noone;
}

/**
* Checks an gamepad axis in a single direction
*
* @function		gamepad_check_axis_strict([slot], [axis], [direction])
* @param		{real}		[slot]			Gamepad slot to check
* @param		{real}		[axis]			Axis to check
* @param		{real}		[direction]		Direction to check
* @return		{real}
* @see			gamepad_button_check
*/
function gamepad_check_axis_strict(_slot=0, _axis=gp_axislh, _direction=1) {
	// Ensure _direction is a whole number
	_direction = sign(_direction);

	// Get axis value
	var axisVal = gamepad_axis_value(_slot, _axis);

	// Check if axis is going the correct direction
	var check = abs(_direction - axisVal);
	
	return (check >= 0) && (check < 1);
}