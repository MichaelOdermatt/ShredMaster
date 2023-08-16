extends Node2D

@onready var spriteAnimationPlayer = $AnimationPlayer;
@onready var playerSprite = $AnimatedSprite2D;

func _ready():
	playerSprite.play("default");

## Playes the On Hit animation for the player.
func playOnHitAnimation():
	# just play the default animation on the animation player since there
	# is only hit on hit animation right now.
	spriteAnimationPlayer.play("FlashOnDamage");
