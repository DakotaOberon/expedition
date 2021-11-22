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
