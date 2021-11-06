if (mouse_check_button_pressed(mb_left)) {
	// Create hitbox
	var hb = instance_create_layer(mouse_x, mouse_y, "Hitbox", oHitbox);

	// Assign values
	hb.damage = 10;
	hb.ttl = 15;
	hb.width = 16;
	hb.height = 16;
	hb.allyTag = "passive";
	hb.x = mouse_x;
	hb.y = mouse_y;
	hb.x1 = hb.x - (hb.width / 2);
	hb.y1 = hb.y - (hb.height / 2);
	hb.x2 = hb.x + (hb.width / 2);
	hb.y2 = hb.y + (hb.height / 2);
}
