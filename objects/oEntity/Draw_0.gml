// Draw current animation
animations.value[$ currentAnim].draw(x, y, id);

var amp = 10;

draw_set_color(c_blue);
draw_line_width(x, y, x + (amp * _currentXSpeed), y + (amp * _currentYSpeed), 2);
draw_text(0, 0, "Current");

draw_set_color(c_green);
draw_line_width(x, y, x + (amp * _xSpeedGoal), y + (amp * _ySpeedGoal), 2);
draw_text(0, 10, "Goal");

draw_set_color(c_red);
draw_line_width(x, y, x + (amp * _xForce), y + (amp * _yForce), 2);
draw_text(0, 20, "Force");

draw_set_color(c_white);