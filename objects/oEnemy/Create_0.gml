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

_health = 20;
_maxHealth = 20;
allyTag = AllyTag.enemy;

target = noone;
combatSight = 120; // Distance to players they will start chasing
loseDistance = 240; // Distance from target before they stop chasing
fleeHealth = irandom(_health / 4); // When to switch to flee state

telegraph = false;

attackPassive = false;