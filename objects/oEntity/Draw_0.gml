// Draw current animation
var x1 = x;
var y1 = y;
if (tookDamage) {
	var dir = irandom(359);
	x += lengthdir_x(damageTook, dir);
	y += lengthdir_y(damageTook, dir);
}
animations.value[$ currentAnim].draw(x1, y1, id);
