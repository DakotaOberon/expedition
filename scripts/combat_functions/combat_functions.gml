/**
* Create a hitbox for damaging entities
* 
* @function		hitbox(x1, y1, width, height, damage, ttl, [allyTag], [statusArray])
* @param		{real}		x1				x of center
* @param		{real}		y1				y of center
* @param		{real}		width			Width of hitbox
* @param		{real}		height			Height of hitbox
* @param		{real}		damage			Damage to deal
* @param		{real}		ttl				Time to live
* @param		{string}	[allyTag]		Tag of which entities to not damage
* @param		{Array}		[statusArray]	Array of statuses to apply to targets hit
* @return		{object}
*/
function hitbox(x1, y1, width, height, damage, ttl, allyTag="passive", statusArray=noone) {
	// Create hitbox
	var hb = instance_create_layer(x1, y1, "Hitbox", oHitbox);

	// Assign values
	hb.width = width;
	hb.height = height;
	hb.damage = damage;
	hb.ttl = ttl;
	hb.allyTag = allyTag;
	hb.x1 = hb.x - (hb.width / 2);
	hb.y1 = hb.y - (hb.height / 2);
	hb.x2 = hb.x + (hb.width / 2);
	hb.y2 = hb.y + (hb.height / 2);

	return hb;
}

/**
* Create a hitcircle for damaging entities
* 
* @function		hitbox(x1, y1, width, height, damage, ttl, [allyTag], [statusArray])
* @param		{real}		x1				x of center
* @param		{real}		y1				y of center
* @param		{real}		radius			Radius of hitcircle
* @param		{real}		damage			Damage to deal
* @param		{real}		ttl				Time to live
* @param		{string}	[allyTag]		Tag of which entities to not damage
* @param		{Array}		[statusArray]	Array of statuses to apply to targets hit
* @return		{object}
*/
function hitcircle(x1, y1, radius, damage, ttl, allyTag="passive", statusArray=noone) {
	// Create hitbox
	var hb = instance_create_layer(x1, y1, "Hitbox", oHitcircle);

	// Assign values
	hb.radius = radius;
	hb.damage = damage;
	hb.ttl = ttl;
	hb.allyTag = allyTag;
	hb.status = statusArray;

	return hb;
}

/**
* Check ds list of targets and apply attack to applicable targets
* 
* @function		check_hit_list(list, hitArr, status=noone, [allyTag])
* @param		{ds_list}	list			ds_list used in collision_list check
* @param		{Array}		hitArr			Array to push applicable targets too
* @param		{Array}		[status]		Array of statuses to apply to applicable targets
* @param		{string}	[allyTag]		Tag of which entities to not damage
*/
function check_hit_list(list, hitArr, status=noone, allyTag="passive") {
	if (hitArr) {
		// Loop over instances inside hitbox
		for(var i = 0; i < ds_list_size(list); i++) {
			// Get instance and parent
			var inst = list[| i];
			var parent = object_get_parent(inst.object_index)

			// Complete attack
			switch (parent) {
				case oEntity:
				case oPlayer:
					if (!hitArr.includes(inst) && allyTag != inst.allyTag) {
						// If not invincible, deal attack
						if (!inst.invincibleTimer) {
							inst._health -= damage;
							inst.tookDamage = true;
							inst.damageTook = damage;
							hitArr.push(inst);
							if (status) {
								// Apply statuses
								for (var j = 0; j < status.getLength(); j++) {
									apply_status(inst, status.value[j]);
								}
							}
						}
					}
				break;
			}
				
		}
	}
}

/**
* Apply a status to an entity
* 
* @function		apply_status(obj, status)
* @param		{instance}	obj				Object to apply status to
* @param		{Status}	y1				Status struct
* @return		{object}
*/
function apply_status(obj, status) {
	switch(status.type) {
		case StatusType.stun:
			var stat = obj.status.stun;
		break;
	}

	if (stat.timer < status.length) {
		stat.timer = status.length;
	}

	return obj;
}
