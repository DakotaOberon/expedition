// Destroy object at end of life
if (ttl > 0) {
	ttl -= 1;
} else {
	instance_destroy();
}
