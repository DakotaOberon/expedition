// Inherit the parent event
event_inherited();

switch (state) {
	case EnemyState.combat:
		if (target) {
			if (!isAttacking) {
				var entDist = entity_distance(target);
				if (entDist <= poke.maxDistance) {
					if (poke.cooldownTimer <= 0) {
						if (!poke.attacking) {
							poke.attacking = true;
							poke._direction = attackDirection;
						}
					}
				} else if (entDist <= fireball.attackDistance) {
					if (fireball.cooldownTimer <= 0) {
						if (!fireball.attacking) {
							fireball.attacking = true;
							fireball._direction = attackDirection;
						}
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
							var knockb = new Status(StatusType.knockback, poke.knockbackLength, poke.knockbackStrength, attackDirection);
							var statArr = new Array([knockb]);
							poke.hitb = hitcircle(x1, y1, poke.radius, poke.damage, poke.length, allyTag, statArr);
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
			} else if (fireball.attacking) {
				isAttacking = true;
				if (fireball.leadTimer > 0) {
					telegraph = true;
					fireball._direction = attackDirection;
					fireball.leadSize += fireball.leadGrowth;
					fireball.leadTimer -= 1;
				} else {
					// Attack
					var knockb = new Status(StatusType.knockback, fireball.knockbackLength, fireball.knockbackStrength, attackDirection);
					var statArr = new Array([knockb]);
					create_projectile(x, y - fireball.yStart, fireball._direction, fireball._speed, fireball.projectile, statArr);

					// Reset
					fireball.cooldownTimer = fireball.cooldown;
					fireball.attacking = false;
					fireball.leadTimer = fireball.leadTime;
					fireball.leadSize = 0;
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

if (fireball.cooldownTimer > 0) {
	fireball.cooldownTimer -= 1;
}

if (!instance_exists(poke.hitb)) {
	poke.hitb = noone;
}
