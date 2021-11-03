// EntityBase animation set
enum animSet {
	idle,
	walkL,
	walkR,
	walkU,
	walkD,
	rollL,
	rollR,
	rollU,
	rollD
}

// Entity Base Animation
global._EntityBaseAnimationTemplate = new AnimationEngine();

var sprIndex = sEntityBase;

global._EntityBaseAnimationTemplate.addAnimation(animSet.walkL, "Walk Left")
	.addFrame(sprIndex, 3, 8, 1)
	.addFrame(sprIndex, 4, 8, 1)
	.addFrame(sprIndex, 5, 8, 1)
	.setEndType(AnimationEndType.reverse);

global._EntityBaseAnimationTemplate.addAnimation(animSet.walkR, "Walk Right")
	.addFrame(sprIndex, 3, 8)
	.addFrame(sprIndex, 4, 8)
	.addFrame(sprIndex, 5, 8)
	.setEndType(AnimationEndType.reverse);

global._EntityBaseAnimationTemplate.addAnimation(animSet.walkD, "Walk Down")
	.addFrame(sprIndex, 0, 8)
	.addFrame(sprIndex, 1, 8)
	.addFrame(sprIndex, 2, 8)
	.setEndType(AnimationEndType.reverse);

global._EntityBaseAnimationTemplate.addAnimation(animSet.walkU, "Walk Up")
	.addFrame(sprIndex, 6, 8)
	.addFrame(sprIndex, 7, 8)
	.addFrame(sprIndex, 8, 8)
	.setEndType(AnimationEndType.reverse);

global._EntityBaseAnimationTemplate.addAnimation(animSet.idle, "Idle")
	.addFrame(sprIndex, 1)
	.setEndType(AnimationEndType.pause);
