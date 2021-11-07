var x1 = x;
var y1 = y;
if (tookDamage) {
	var dir = irandom(359);
	x1 += lengthdir_x(damageTook, dir);
	y1 += lengthdir_y(damageTook, dir);
}

draw_set_color(tookDamage? c_red : c_white);
draw_sprite(sprite_index, 0, x1, y1);
draw_set_color(c_white);
