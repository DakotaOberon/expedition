#region Enums

// EntityBase animation set
enum animSet {
	idle,
	walkL,
	walkR,
	walkU,
	walkD
}

enum DefaultClassAnimSet {
	cleaveIdle,
	cleaveL,
	cleaveR,
	cleaveU,
	cleaveD
}

enum EnemyImpAnimSet {
	poke
}

enum StatusType {
	stun,
	knockback
}

#endregion

#region Entity Base Animation Templete

// Entity Base Animation
global._EntityBaseAnimationTemplate = new AnimationEngine();
var sprIndex = sEntityBase;

global._EntityBaseAnimationTemplate.addAnimation(animSet.walkL, "Walk Left")
	.addFrame(sprIndex, 3, 8, FrameFlip.xFlip)
	.addFrame(sprIndex, 4, 8, FrameFlip.xFlip)
	.addFrame(sprIndex, 5, 8, FrameFlip.xFlip)
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

#endregion

#region Default Class
global._DefaultClass = new AnimationEngine();
sprIndex = sWeaponSword;

global._DefaultClass.addAnimation(DefaultClassAnimSet.cleaveIdle, "Cleave Idle")
	.addFrame(sprIndex, 0)
	.setEndType(AnimationEndType.pause);

global._DefaultClass.addAnimation(DefaultClassAnimSet.cleaveL, "Cleave Left")
	.addFrame(sprIndex, 0, 3, FrameFlip.none, 0, 0, 45)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 53)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 71)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 89)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 107)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 125)
	.setEndType(AnimationEndType.pause);

global._DefaultClass.addAnimation(DefaultClassAnimSet.cleaveR, "Cleave Right")
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 45)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 27)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 9)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 351)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 333)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 315)
	.setEndType(AnimationEndType.pause);

global._DefaultClass.addAnimation(DefaultClassAnimSet.cleaveU, "Cleave Up")
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 90)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 72)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 54)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 36)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 18)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 0)
	.setEndType(AnimationEndType.pause);

global._DefaultClass.addAnimation(DefaultClassAnimSet.cleaveD, "Cleave Down")
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 180)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 198)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 216)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 234)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 252)
	.addFrame(sprIndex, 0, 1, FrameFlip.none, 0, 0, 270)
	.setEndType(AnimationEndType.pause);

#endregion

#region Statuses

global._StatusStun = new AnimationEngine();
sprIndex = sStatusStun;

global._StatusStun.addAnimation(StatusType.stun, "Stun")
	.addFrame(sprIndex, 0, 6)
	.addFrame(sprIndex, 1, 6)
	.addFrame(sprIndex, 2, 6)
	.addFrame(sprIndex, 3, 6)
	.addFrame(sprIndex, 0, 6, FrameFlip.both, 0, -25)
	.addFrame(sprIndex, 1, 6, FrameFlip.both, 0, -25)
	.addFrame(sprIndex, 2, 6, FrameFlip.both, 0, -25)
	.addFrame(sprIndex, 3, 6, FrameFlip.both, 0, -25);

#endregion

#region Imp Enemy

global._EnemyImp = new AnimationEngine();
sprIndex = sWeaponTrident;

global._EnemyImp.addAnimation(EnemyImpAnimSet.poke, "Poke")
	.addFrame(sprIndex, 0, 1, 0, 0, 0, 315)
	.setEndType(AnimationEndType.pause);

#endregion

//_sprIndex, _subImg, _length=1, _xFlip=false, _xOffset=0, _yOffset=0, _rotation=0, _color=c_white