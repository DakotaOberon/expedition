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
	leadTime: 30,
	leadTimer: 30,
	leadSize: 0,
	leadGrowth: 0,
	damage: 1,
	ttl: 180,
	cooldown: 120,
	cooldownTimer: 0,
	projectile: new Projectile(sProjectileFireball, true, 320, true, 3),
	attackDistance: 120,
	attacking: false,
	_direction: 0,
	_speed: 4,
	size: 4,
	yStart: 12,
}

fireball.leadGrowth = (1 / fireball.leadTime);
fireball.projectile.setHitbox(HitboxType.circle, fireball.size, 0, fireball.damage, fireball.ttl, AllyTag.enemy, noone);

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

status.stun.run = function reset() {
	isAttacking = false;
	// Reset poke
	poke.cooldownTimer = poke.cooldown;
	poke.attacking = false;
	poke.timer = poke.length;
	poke.leadTimer = poke.leadTime;
	poke.leadDirectionTimer = poke.leadDirectionTime;
	poke.distance = 0;
}
