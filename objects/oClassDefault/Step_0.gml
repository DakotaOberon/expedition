// Inherit the parent event
event_inherited();

// Sprint code
if (controls.check("sprint")) {
	moveSpeed = sprint._speed;
} else {
	moveSpeed = sprint.normalSpeed;
}

// Dash to dodge
if (controls.checkPress("dash") && dash.cooldownTimer <= 0) {
	// Set dash timer and direction
	dash.timer = dash.length;
	dash._direction = point_direction(x, y, mouse_x, mouse_y);
	// Set dash origin for drawing
	dash.drawX = x;
	dash.drawY = y;
	dash.cooldownTimer = dash.cooldown;

	// Set invincibility
	if (invincibleTimer < dash.length) {
		invincibleTimer = dash.length;
	}
}

if (dash.timer > 0) {
	// Set current speed in direction of dash
	_currentXSpeed = lengthdir_x(dash._speed, dash._direction);
	_currentYSpeed = lengthdir_y(dash._speed, dash._direction);
	dash.timer -= 1;
} else if (dash.cooldownTimer > 0) {
	dash.cooldownTimer -= 1;
}

// Cleave
if (controls.checkPress("cleave") && cleave.cooldownTimer <= 0) {
	// Set cleave animation
	switch (currentAnim) {
		case animSet.walkL:
			cleave.currentAnim = DefaultClassAnimSet.cleaveL;
		break;
		case animSet.walkR:
			cleave.currentAnim = DefaultClassAnimSet.cleaveR;
		break;
		case animSet.walkU:
			cleave.currentAnim = DefaultClassAnimSet.cleaveU;
		break;
		case animSet.walkD:
			cleave.currentAnim = DefaultClassAnimSet.cleaveD;
		break;
		default:
			cleave.currentAnim = DefaultClassAnimSet.cleaveIdle;
		break;
	}

	// Set timers
	cleave.timer = cleave.length;
	cleave.cooldownTimer = cleave.cooldown;

	// Get cleave hitbox x and y
	var xDir = lengthdir_x(cleave.distance, attackDirection) + cleave.xOffSet;
	var yDir = lengthdir_y(cleave.distance, attackDirection) + cleave.yOffSet;

	// Set cleave damage
	var dmg = cleave.damage;
	var statuses = new Array();
	var knockback = noone;
	if (dash.timer > 0) {
		dmg += 5;
	} else {
		// Knockback if not dashing
		knockback = new Status(StatusType.knockback, cleave.knockbackDuration, cleave.knockbackStrength, 0);
		statuses.push(knockback);
	}

	// Create hitcircle
	cleave.hitb = hitcircle(x + xDir, y + yDir, cleave.radius, dmg, cleave.length, allyTag, statuses);
	if (knockback) {
		knockback._direction = point_direction(x, y, cleave.hitb.x, cleave.hitb.y);
	}

	// Make sure attack animation starting at frame 0
	cleave.animation.value[$ cleave.currentAnim].currentFrame = 0;
}

if (cleave.timer > 0) {
	if (instance_exists(cleave.hitb)) {
		// Update cleave x and y
		var xDir = x + lengthdir_x(cleave.distance, attackDirection) + cleave.xOffSet;
		var yDir = y + lengthdir_y(cleave.distance, attackDirection) + cleave.yOffSet;
		cleave.hitb.x = xDir;
		cleave.hitb.y = yDir;
	}
	cleave.timer -= 1;
	// Increment frame
	// TODO: Don't use global here
	cleave.animation.value[$ cleave.currentAnim].frameStep();
} else if (cleave.cooldownTimer > 0) {
	cleave.cooldownTimer -= 1;
}

if (controls.checkPress("kick") && kick.cooldownTimer <= 0) {
	// Get nearest potential target
	var potentialTarget = instance_nearest_notme(x, y, oEntity, id, allyTag);
	if (instance_exists(potentialTarget)) {
			if (entity_distance(potentialTarget) <= kick.detectRadius) {
				// If target is within radius, set target
				kick.target = potentialTarget;
				if (dash.timer > 0) {
					kick.dashDirection = dash._direction;
					kick.dealDash = true;
				}
			}
	}

	kick.timer = kick.length;
	kick.cooldownTimer = kick.cooldown;
}

if (kick.timer > 0) {
	// Increment move frame by 2 to simulate kick
	animations.value[$ currentAnim].frameStep(2);
	if (!kick.target) {
		// If no target was found, try to find a target again each frame kick is active
		var potentialTarget = instance_nearest_notme(x, y, oEntity, id, allyTag);
		if (instance_exists(potentialTarget)) {
			if (entity_distance(potentialTarget) <= kick.detectRadius) {
				// If target is within radius, set target
				kick.target = potentialTarget;
				if (dash.timer > 0) {
					kick.dashDirection = dash._direction;
					kick.dealDash = true;
				}
			}
		}
	} else {
		// Turn player towards kick while active
		var kickDir = point_direction(x, y, kick.target.x, kick.target.y + kick.yOffSet);
		if (kickDir >= 0 && kickDir <= 45) || (kickDir >= 315 && kickDir <= 360) {
			currentAnim = animSet.walkR;
		} else if (kickDir >= 135 && kickDir <= 225) {
			currentAnim = animSet.walkL;
		} else if (kickDir > 45 && kickDir < 135) {
			currentAnim = animSet.walkU;
		} else {
			currentAnim = animSet.walkD;
		}
	}
	kick.timer -= 1;

	// Perform kick at end of kick length
	if (kick.timer == 0) {
		if (kick.target) {
			var dmg = kick.parry? kick.parryDamage : kick.damage;
			var stun = new Status(StatusType.stun, kick.stunDuration);
			var knockbackDirection = point_direction(x, y, kick.target.x, kick.target.y);
			
			var knockback = new Status(StatusType.knockback, kick.knockbackDuration, kick.knockbackStrength, knockbackDirection);
			var statusArray = new Array([stun, knockback]);

			if (kick.dealDash) {
				var knockback2 = new Status(StatusType.knockback, kick.knockbackDuration, kick.dashKnockbackStrength, kick.dashDirection);
				statusArray.push(knockback2);
				dmg += 1;
			}

			kick.hitb = hitcircle(kick.target.x, kick.target.y, kick.size, dmg, kick.ttl, allyTag, statusArray);
			kick.target = noone;
			kick.dealDash = false;
			kick.parry = false;
		} else {
			kick.cooldownTimer = 0;
		}
	}
} else if (kick.cooldownTimer > 0) {
	// Increment move step by 2 to indicate when it's off cooldown
	animations.value[$ currentAnim].frameStep(2);
	kick.cooldownTimer -= 1;
}
