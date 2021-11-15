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
			var currSpd = point_distance(x, y, x + _currentXSpeed, y + _currentYSpeed);

			// Set friction
			var f = self._friction;
			var surf = collision_point(x, y, oSurface, 0, 1);
			if (surf) {	
				f = surf._friction;
			}

			var lastI = currSpd / (_acceleration * f);
			var tempStopDistance = 0;
			for(var i = 0; i <= lastI; i++) {
				var addI = i * (_acceleration * f);
				tempStopDistance += addI;
			}
			stopDistance = max(tempStopDistance, stopDistance);

			if (distToDestination <= stopDistance) {
				_xSpeedGoal = 0;
				_ySpeedGoal = 0;
			} else {
				// Clamp to moveSpeed
				distToDestination = clamp(distToDestination, 0, moveSpeed);
				// Set x and y speed goals
				_xSpeedGoal = lengthdir_x(distToDestination, _direction);
				_ySpeedGoal = lengthdir_y(distToDestination, _direction);
			}

			wanderTimer -= 1;
		}
	break;
}

// Inherit the parent event
event_inherited();