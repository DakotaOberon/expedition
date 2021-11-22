// Draw Passive
if (passive.timer > 0) {
	animations.value[$ currentAnim].draw(x - 1, y, 0.5, c_red);
	animations.value[$ currentAnim].draw(x + 1, y, 0.5, c_red);
	animations.value[$ currentAnim].draw(x, y - 1, 0.5, c_red);
	animations.value[$ currentAnim].draw(x, y + 1, 0.5, c_red);
}

// Inherit the parent event
event_inherited();

// Draw Dash
if (dash.timer > 0) {
	wind_lines(x, y, dash.drawX, dash.drawY, 6, 4);
}

if (cleave.timer > 0) {
	// Offset cleave from hitbox
	var drawDir = point_direction(cleave.hitb.x, cleave.hitb.y, x, y);
	var xOff = lengthdir_x(cleave.drawOffset, drawDir);
	var yOff = lengthdir_y(cleave.drawOffset, drawDir);
	if (cleave.timer > 4) {
		// Wind lines
		var wDir = drawDir;
		var wYOff = 0;
		// Set specific wind variables
		switch (cleave.currentAnim) {
			case DefaultClassAnimSet.cleaveD:
				wYOff = 8;
			case DefaultClassAnimSet.cleaveL:
				wDir -= 90;
			break;
			case DefaultClassAnimSet.cleaveU:
			case DefaultClassAnimSet.cleaveR:
				wDir += 90;
			break;
		}
		// Set additional wind values
		var wW = 8;
		var wX = lengthdir_x(wW, wDir);
		var wY = lengthdir_y(wW, wDir);
		var wLX = lengthdir_x(cleave.timer, wDir);
		var wLY = lengthdir_y(cleave.timer, wDir);
		// Draw wind lines
		wind_lines(cleave.hitb.x - wX, cleave.hitb.y - wY + wYOff, cleave.hitb.x + wX - wLX, cleave.hitb.y + wY - wLY + wYOff, 4, 3);
	}
	// Draw cleave
	cleave.animation.value[$ cleave.currentAnim].draw(cleave.hitb.x + xOff, cleave.hitb.y + yOff, 1);
}
