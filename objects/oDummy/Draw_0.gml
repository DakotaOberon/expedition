draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, 1);

if (status.stun.timer > 0) {
	global._StatusStun.value[$ StatusType.stun].draw(x, y, 0.6);
}
