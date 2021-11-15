// Passive
if (tookDamage) && (passive.cooldownTimer <= 0) {
	// Set passive timer
	passive.timer = passive.length;
	// Set passive cooldown
	passive.cooldownTimer = passive.cooldown;

	// Set invincibility
	if (invincibleTimer < passive.length) {
		invincibleTimer = passive.length;
	}
}

if (passive.timer > 0) {
	// Reduce passive timer
	passive.timer -= 1;
} else if (passive.cooldownTimer > 0) {
	// Reduce passive cooldown if it is no longer active
	passive.cooldownTimer -= 1;
}

// Inherit the parent event
event_inherited();
