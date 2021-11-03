// Set current animation to idle
currentAnim = animSet.idle;

_xSpeed = 0;
_ySpeed = 0;
_direction = 0;

_health = 0;
_speed = 0;

animations = new AnimationEngine();
animationsInit = EntityAnimationsInit;
animationsCopy = EntityAnimationTemplateCopy;

animationsInit();

// Set movespeed
moveSpeed = 2;

// Initiate values used in movement calculations
_lastX = 0;
_lastY = 0;

xTo = x;
yTo = y;
