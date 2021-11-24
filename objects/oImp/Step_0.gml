// Inherit the parent event
event_inherited();

switch (state) {
	case EnemyState.wander:
	break;
	case EnemyState.combat:
		if (target) {
			if (entity_distance(target) <= poke.maxDistance) {
				if (poke.cooldownTimer <= 0) {
					if (!poke.attacking) {
						poke.attacking = true;
						poke._direction = attackDirection;
					}
				}
			}

			if (poke.attacking) {
				isAttacking = true;
				if (poke.leadTimer > 0) {
					// Lead the attack
					telegraph = true;
					if (poke.leadDirectionTimer > 0) {
						poke._direction = attackDirection
						poke.leadDirectionTimer -= 1;
					}
					poke.leadTimer -= 1;
				} else {
					if (poke.timer > 0) {
						// Attack
						var pSpeed = (poke.maxDistance / poke.length);
						poke.distance = approach(poke.distance, poke.maxDistance, pSpeed);
						poke.timer -= 1;
						var x1 = x + lengthdir_x(poke.distance - poke.leadOffset, poke._direction);
						var y1 = y + lengthdir_y(poke.distance - poke.leadOffset, poke._direction);
						if (!poke.hitb) {
							poke.hitb = hitcircle(x1, y1, poke.radius, poke.damage, poke.length, allyTag);
						} else {
							var xOff = lengthdir_x(poke.hitbDirOffset, poke._direction);
							var yOff = lengthdir_y(poke.hitbDirOffset, poke._direction);
							poke.hitb.x = x1 + poke.hitbXOffset + xOff;
							poke.hitb.y = y1 + poke.yOffset + poke.hitbYOffset + yOff;
						}
					} else {
						// Reset for next attack
						poke.cooldownTimer = poke.cooldown;
						poke.attacking = false;
						poke.timer = poke.length;
						poke.leadTimer = poke.leadTime;
						poke.leadDirectionTimer = poke.leadDirectionTime;
						poke.distance = 0;
					}
				}
			} else {
				isAttacking = false;
			}
		}
	break;
}

if (poke.cooldownTimer > 0) {
	poke.cooldownTimer -= 1;
}

if (!instance_exists(poke.hitb)) {
	poke.hitb = noone;
}
