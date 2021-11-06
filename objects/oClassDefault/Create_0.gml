// Inherit the parent event
event_inherited();

// Dash
dash = {
	timer: 0,
	_direction: 0,
	_speed: 5,
	length: 15,
	cooldown: 180,
	cooldownTimer: 0,
	drawX: 0,
	drawY: 0
}

// Sprint
sprint = {
	normalSpeed: self.moveSpeed,
	_speed: (self.moveSpeed * 1.5)
}

passive = {
	timer: 0,
	length: 30,
	cooldown: 300,
	cooldownTimer: 0
}