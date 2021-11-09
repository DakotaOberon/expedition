// Draw Kick
if (instance_exists(kick.target)) {
	var kickY1 = kick.target.y + kick.yOffSet;
	var kickDir = point_direction(x, y, kick.target.x, kickY1);
	var flip = sign(kick.target.x - x);
	// Draw kick sprite
	draw_sprite_ext(sClassDefaultKick, 0, kick.target.x, kickY1, 1, flip, kickDir, color, 1);
	var kickWXOff = lengthdir_x(4, kickDir);
	var kickWYOff = lengthdir_y(4, kickDir);
	// Draw wind lines
	wind_lines(x + kickWXOff, y + kickWYOff, kick.target.x, kickY1, 2, 3);
}
