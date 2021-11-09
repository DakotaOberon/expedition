/**
* Draw wind lines to animate speed
* 
* @function		wind_lines(x1, y1, x2, y2, width, [lines], [color1], [color2])
* @param		{real}		x1				x of origin
* @param		{real}		y1				y of origin
* @param		{real}		x2				x of destination
* @param		{real}		y2				y of destination
* @param		{real}		width			Width of area wind lines cover
* @param		{real}		[lines]			Number of wind lines to draw
* @param		{color}		[color1]		Starting color of wind lines
* @param		{color}		[color1]		Ending color of wind lines
*/
function wind_lines(x1, y1, x2, y2, width, lines=4, color1=c_white, color2=c_white) {
	var hW = (width / 2);
	var dir = point_direction(x1, y1, x2, y2);
	var xDir = lengthdir_x(width, dir + 90);
	var yDir = lengthdir_y(width, dir + 90);
	// Draw dash wind lines
	draw_set_alpha(0.2);
	var i = 1;
	repeat(lines) {
		var randomXVariance = irandom_range(-xDir, xDir);
		var randomYVariance = irandom_range(-yDir, yDir);
		draw_line_color(x1 + randomXVariance, y1 - (i * hW) + randomYVariance, x2 + randomXVariance, y2 - (i * hW) + randomYVariance, color1, color2);
		i += 1;
	}
	draw_set_alpha(1);
}
