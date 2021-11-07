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

// Cleave
cleave = {
	damage: 9,
	timer: 0,
	length: 15,
	radius: 12,
	xOffSet: 0,
	yOffSet: -5,
	distance: 8,
	cooldown: 15,
	cooldownTimer: 0,
	hitb: noone,
	sprite: sSword
}

// Passive
passive = {
	timer: 0,
	length: 300,
	cooldown: 300,
	cooldownTimer: 0
}

_health = 100;