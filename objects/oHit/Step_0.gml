// Destroy object at end of life
if (ttl > 0) {
	ttl -= 1;
} else {
	instance_destroy();
}

// Check hitFreq on each entity
if (hit) {
	for(var i = hit.getLength() - 1; i >= 0; i--) {
		// Remove entities with ttl of 0 from hit list so it may be hit again
		if (hit.value[i].ttl <= 0) {
			hit.remove(i);
		} else {
			hit.value[i].ttl -= 1;
		}
	}
}
