/**
* Gamepad constructor
*
* @function		Gamepad(slot, [connected], [playing])
* @param		{real}		slot			Slot gamepad is connected to
* @param		{boolean}	[connected]		If gamepad is connected
* @param		{boolean}	[playing]		If gamepad is currently being used by a player
*/
function Gamepad(_slot, _connected=true, _playing=true) constructor {
	slot = _slot;
	connected = _connected;
	playing = _playing;

	check = GamepadCheck;
	setPlaying = GamepadSetPlaying;
}

/**
* Checks gamepad connection status
*
* @function		GamepadCheck()
* @returns		{self}
*/
function GamepadCheck() {
	self.connected = gamepad_is_connected(self.slot);

	return self;
}

/**
* Sets gamepad playing value
*
* @function		GamepadSetPlaying([isPlaying])
* @param		{boolean}	[isPlaying]		Value to set self.playing to
* @returns		{self}
*/
function GamepadSetPlaying(isPlaying=true) {
	self.playing = isPlaying;

	return self;
}
