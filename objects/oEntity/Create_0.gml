// Set current animation to idle
currentAnim = animSet.idle;

// Variable speed values used in movement calculations
_xSpeed = 0;
_ySpeed = 0;
_xSpeedGoal = 0;
_ySpeedGoal = 0;
_xAcceleration = 0;
_yAcceleration = 0;
_currentXSpeed = 0;
_currentYSpeed = 0;
_directionGoal = 0;
_xForce = 0;
_yForce = 0;
_friction = 1;

// Static values used in movement calculations
_acceleration = 0.1;
moveSpeed = 2;
_direction = 0;

_health = 0;

animations = new AnimationEngine();
animationsInit = EntityAnimationsInit;
animationsCopy = EntityAnimationTemplateCopy;

animationsInit();

// Initiate values used in movement calculations
_lastX = 0;
_lastY = 0;

xTo = x;
yTo = y;
