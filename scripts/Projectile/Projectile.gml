enum WallCollision {
	stop,
	destroy,
	bounce,
	mirror,
	phase
}

function Projectile(_spr=sProjectileBasic, _desOnT=false, _desOnTDis=0, _desOnH=false, _desOnHNum=0, _ttl=3600, _hitFreq=30, _wallColl=WallCollision.destroy) constructor {
	sprite = _spr;
	destroyOnTravel = _desOnT;
	destroyOnTravelDistance = _desOnTDis;
	destroyOnHits = _desOnH;
	destroyOnHitsNumber = _desOnHNum;
	ttl = _ttl;
	hitTimer = _hitFreq;
	hitCooldown = _hitFreq;
	wallCollisionType = _wallColl;
	hitbValues = { }

	hitbCreate = ProjectileCreateHitbox;
	setHitbox = ProjectileSetHitboxValues;
}

enum HitboxType {
	box,
	circle
}

function ProjectileSetHitboxValues(type=HitboxType.circle, radiusOrW=1, height=1, damage=0, ttl=1, allyTag="passive") {
	hitbValues.type = type;
	hitbValues.damage = damage;
	hitbValues.ttl = ttl;
	hitbValues.allyTag = allyTag;

	switch (type) {
		case HitboxType.circle:
			hitbValues.radius = radiusOrW;
		break;
		case HitboxType.box:
			hitbValues.width = radiusOrW;
			hitbValues.height = height;
		break;
	}
}

function ProjectileCreateHitbox(x1, y1, statusArray=noone) {
	var hit = noone;
	switch (hitbValues.type) {
		case HitboxType.circle:
			hit = hitcircle(x1, y1, hitbValues.radius, hitbValues.damage, hitbValues.ttl, hitbValues.allyTag, statusArray);
		break;
		case HitboxType.box:
			hit = hitbox(x1, y1, hitbValues.width, hitbValues.height, hitbValues.damage, hitbValues.ttl, hitbValues.allyTag, statusArray);
		break;
	}

	return hit;
}