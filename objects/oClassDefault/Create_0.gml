// Inherit the parent event
event_inherited();

// Dash
dash = {
	timer: 0,
	_direction: 0,
	_speed: 5,
	length: 15,
	cooldown: 15,
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
	distance: 18,
	cooldown: 15,
	cooldownTimer: 0,
	hitb: noone,
	currentAnim: DefaultClassAnimSet.cleaveIdle,
	drawOffset: 10
}

kick = {
	timer: 0,
	length: 5,
	size: 4,
	damage: 1,
	ttl: 1,
	detectRadius: 16,
	stunDuration: 120,
	knockbackDuration: 60,
	knockbackStrength: 3,
	cooldown: 60,
	cooldownTimer: 0,
	// Parry if used during enemy attack
	parryDamage: 18,
	parryLength: 8,
	parryTimer: 0,
	parry: false,
	target: noone,
	hitb: noone,
	yOffSet: -8
}

// Passive
passive = {
	timer: 0,
	length: 300,
	cooldown: 300,
	cooldownTimer: 0
}

_health = 100;
_maxHealth = 100;