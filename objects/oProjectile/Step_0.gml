// Calculate distance traveled
distanceTraveled += point_distance(x, y, lastX, lastY);

if (destroyOnTravel) {
	if (distanceTraveled >= destroyOnTravelDistance) {
		instance_destroy();
	}
}

// Calculate hits
if (destroyOnHits) {
	if (instance_exists(hitb)) {
		// Set hit starting variables
		var countHit = false;
		var amountHit = 0;
		var hitListSize = hitb.hit.getLength();


		if (hitListSize > lastHitAmount) {
			// Check if any new targets have been hit
			countHit = true;
			amountHit = hitListSize - lastHitAmount;
			lastHitAmount = hitListSize;
		}

		if (hitTimer <= 0) {
			// Reset hit counter on new hitbox
			lastHitAmount = 0;
		}

		totalHit += amountHit;
	}

	if (totalHit >= destroyOnHitsNumber) {
		instance_destroy();
	}
}

// Get ttl
if (ttl <= 0) {
	instance_destroy();
}

ttl -= 1;

var xMove = lengthdir_x(_speed, _direction);
var yMove = lengthdir_y(_speed, _direction);

if (place_meeting(x + xMove, y + yMove, oWall)) {
	switch (wallCollisionType) {
		case WallCollision.destroy:
			instance_destroy();
		break;
	}
}

lastX = x;
lastY = y;

x += xMove;
y += yMove;

if (instance_exists(hitb)) {
	hitb.x = x;
	hitb.y = y;
}

depth = -y - 16;
