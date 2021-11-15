// Inherit the parent event
event_inherited();

color = make_color_hsv(255, 255, 255);

// Set color for testing
animations.updateAll(
	"color",
	color
);

state = EnemyState.wander;

// Wander
wanderCooldown = 600;
wanderTimer = 0;
wanderDestination = {
	x: 0,
	y: 0
}

wanderDistance = 160;
stopDistance = 0;

_health = 200;
