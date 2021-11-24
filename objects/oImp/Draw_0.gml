// Inherit the parent event
event_inherited();

if (poke.attacking) {
	var x1 = x + lengthdir_x(poke.distance - poke.leadOffset, poke._direction);
	var y1 = y + lengthdir_y(poke.distance - poke.leadOffset, poke._direction);
	var pokeDir = (poke._direction - 45);
	if (pokeDir < 0) {
		pokeDir += 360;
	}

	global._EnemyImp.value[$ EnemyImpAnimSet.poke].draw(x1, y1 + poke.yOffset, 1, noone, pokeDir);
}

if (fireball.attacking) {
	if (fireball.leadTimer > 0) {
		draw_sprite_ext(sProjectileFireball, 0, x, y - fireball.yStart, fireball.leadSize, fireball.leadSize, attackDirection, c_white, fireball.leadSize);
	}
}