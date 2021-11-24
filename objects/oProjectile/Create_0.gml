hitb = noone;
lastHitAmount = 0;
totalHit = 0;

hitbCreate = blank();
sprite = sProjectileBasic;

// Time to live variables
destroyOnTravel = false;
destroyOnTravelDistance = 0;
distanceTraveled = 0;

ttl = 3600;

destroyOnHits = false;
destroyOnHitsNumber = 0;

// Time until new hitbox is created
hitCooldown = 30;
hitTimer = hitCooldown;

// End functions
endFunction = blank();

drawProjectileOnHit = false;
drawProjectileOnHitIfKilled = false;
createObject = false;
objectToCreate = noone;
destroySelf = false;

_direction = 0;
_speed = 0;

lastX = x;
lastY = y;

wallCollisionType = WallCollision.destroy;