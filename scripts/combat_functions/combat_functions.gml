/**
* Create a hitbox for damaging entities
* 
* @function		hitbox(x1, y1, width, height, damage, ttl, [allyTag])
* @param		{real}		x1				x of center
* @param		{real}		y1				y of center
* @param		{real}		width			Width of hitbox
* @param		{real}		height			Height of hitbox
* @param		{real}		damage			Damage to deal
* @param		{real}		ttl				Time to live
* @param		{string}	[allyTag]		Tag of which entities to not damage
* @return		{object}
*/
function hitbox(x1, y1, width, height, damage, ttl, allyTag="passive") {
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

function hitcircle(x1, y1, radius, damage, ttl, allyTag="passive") {
	// Create hitbox
	var hb = instance_create_layer(x1, y1, "Hitbox", oHitcircle);

	// Assign values
	hb.radius = radius;
	hb.damage = damage;
	hb.ttl = ttl;
	hb.allyTag = allyTag;

	return hb;
}