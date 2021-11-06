// Draw Passive
if (passive.timer > 0) {
	animations.value[$ currentAnim].draw(x - 1, y, id, 0.5, c_red);
	animations.value[$ currentAnim].draw(x + 1, y, id, 0.5, c_red);
	animations.value[$ currentAnim].draw(x, y - 1, id, 0.5, c_red);
	animations.value[$ currentAnim].draw(x, y + 1, id, 0.5, c_red);
}

// Inherit the parent event
event_inherited();

// Draw Dash
if (dash.timer > 0) {
	// Draw dash wind lines
	draw_set_alpha(0.2);
	var windColor = c_white;
	var i = 1;
	repeat(4) {
		var randomXVariance = irandom_range(-8, 8);
		var randomYVariance = irandom_range(-2, 2);
		draw_line_color(x + randomXVariance, y - (i * 3) + randomYVariance, dash.drawX + randomXVariance, dash.drawY - (i * 3) + randomYVariance, windColor, windColor);
		i += 1;
	}
	draw_set_alpha(1);
}

draw_text(x, y, invincibleTimer);