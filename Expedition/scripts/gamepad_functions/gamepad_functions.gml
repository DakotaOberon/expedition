/**
* Checks if any buttons on a gamepad is being pressed and returns which button
*
* @function		gamepad_check_any([slot])
* @param		{real}		[slot]			Gamepad slot to check
* @return		{real}
* @see			gamepad_button_check
*/
function gamepad_check_any(_slot=0) {
	// Loop over each possible gp button
	for (var i = gp_face1; i <= gp_axisrv; i++ ) {
	    if (gamepad_button_check(_slot, i )) {
			return i;
		}
	}
	return noone;
}
