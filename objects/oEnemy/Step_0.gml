switch (state) {
	case EnemyState.wander:
		moveSpeed = 1;
		inCombat = false;
		if (wanderTimer <= 0) {
			// Set destination variables
			_direction = irandom(359);
			_xSpeedGoal = 0;
			_ySpeedGoal = 0;

			var dist = irandom(wanderDistance);

			// Get wander destination point
			wanderDestination.x = x + lengthdir_x(dist, _direction);
			wanderDestination.y = y + lengthdir_y(dist, _direction);
			wanderTimer = irandom(wanderCooldown);
			stopDistance = 0;
		} else {
			// Get distance to destination
			var distToDestination = point_distance(x, y, wanderDestination.x, wanderDestination.y);

			// Update direction
			_direction = point_direction(x, y, wanderDestination.x, wanderDestination.y);

			ai_update_movement(distToDestination)

			wanderTimer -= 1;
		}

		if (!target) {
			var potentialTarget = instance_nearest_notme(x, y, oEntity, id, allyTag);
			
			if (potentialTarget) {
				if (point_distance(x, y, potentialTarget.x, potentialTarget.y) <= combatSight) {
					target = potentialTarget;
				
					state = EnemyState.combat;
				}
			}
		}
	break;
	case EnemyState.combat:
		inCombat = true;
		if (instance_exists(target)) {
			_direction = point_direction(x, y, target.x, target.y);
			attackDirection = _direction;

			var distToDestination = point_distance(x, y, target.x, target.y);
			if (distToDestination > loseDistance) {
				target = noone;
				state = EnemyState.wander;
			} else {
				// Simple collsion system
				var col = collision_point(x + _currentXSpeed, y + _currentYSpeed, oWall, 0, 1);
				
				var dirChoice = 0;
				if (!col) {
					// Entity Collision
					col = collision_point(x + _currentXSpeed, y + _currentYSpeed, oEntity, 0, 1);
					if (col) {
						dirChoice = choose(-45, 45);
					}
				} else {
					// Wall Collision
					dirChoice = choose(-90, 90);
				}

				_direction += dirChoice;
				ai_update_movement(distToDestination);
			}
		} else {
			target = noone;
			state = EnemyState.wander;
			var potentialTarget = instance_nearest_notme(x, y, oEntity, id, allyTag);

			if (potentialTarget) {
				if (point_distance(x, y, potentialTarget.x, potentialTarget.y) <= combatSight) {
					target = potentialTarget;
					state = EnemyState.combat;
				}
			}
		}
	break;
}

telegraph = false;

// Inherit the parent event
event_inherited();