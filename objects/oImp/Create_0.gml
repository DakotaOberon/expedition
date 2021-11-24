// Inherit the parent event
event_inherited();

animations.updateAll(
	"spriteIndex",
	sEntityImp
).updateAll(
	"color",
	c_white
);

fireball = {
	
}

poke = {
	leadTime: 30,
	leadTimer: 30,
	leadDirectionTime: 15,
	leadDirectionTimer: 15,
	leadOffset: 4,
	length: 16,
	timer: 16,
	cooldown: 120,
	cooldownTimer: 0,
	maxDistance: 16,
	distance: 0,
	damage: 3,
	attacking: false,
	hitb: noone,
	hitbDirOffset: 16,
	hitbYOffset: -1,
	hitbXOffset: -1,
	_direction: 0,
	yOffset: -6,
	radius: 4
}

weapon = sWeaponTrident;
