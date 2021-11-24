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
	knockbackDuration: 5,
	knockbackStrength: 3,
	cooldown: 15,
	cooldownTimer: 0,
	hitb: noone,
	animation: new AnimationEngine(),
	currentAnim: DefaultClassAnimSet.cleaveIdle,
	drawOffset: 10
}

// Cleave init
cleave.animation.copy(global._DefaultClass);

kick = {
	timer: 0,
	length: 5,
	size: 4,
	damage: 1,
	ttl: 5,
	detectRadius: 16,
	stunDuration: 65,
	knockbackDuration: 5,
	knockbackStrength: 6,
	dashKnockbackStrength: 3,
	dashDirection: 0,
	dealDash: false,
	cooldown: 60,
	cooldownTimer: 0,
	// Parry if used during enemy attack
	parryDamage: 18,
	parry: false,
	target: noone,
	hitb: noone,
	yOffSet: -8
}

// Passive
passive = {
	timer: 0,
	length: 30,
	cooldown: 30,
	cooldownTimer: 0
}

_health = 100;
_maxHealth = 100;

weapon = sWeaponSword;
