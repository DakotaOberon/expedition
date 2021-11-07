// Destroy object at end of life
if (ttl > 0) {
	ttl -= 1;
} else {
	instance_destroy();
}

// Create temporary ds list to hold collision
var tmpDS = ds_list_create();

collision_circle_list(x, y, radius, all, 0, 1, tmpDS, true);

// Loop over instances inside hitbox
for(var i = 0; i < ds_list_size(tmpDS); i++) {
	// Get instance and parent
	var inst = tmpDS[| i];
	var parent = object_get_parent(inst.object_index)

	// Complete attack
	switch (parent) {
		case oEntity:
		case oPlayer:
			if (!hit.includes(inst) && allyTag != inst.allyTag) {
				// If not invincible, deal attack
				if (!inst.invincibleTimer) {
					inst._health -= damage;
					inst.tookDamage = true;
					inst.damageTook = damage;
					hit.push(inst);
				}
			}
		break;
	}
}

ds_list_destroy(tmpDS);
