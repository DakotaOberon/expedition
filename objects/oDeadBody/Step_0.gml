// Inherit the parent event
event_inherited();

alpha -= alphaDec;

if (ttl <= 0) {
	instance_destroy();
}

ttl -= 1;
