extends Node2D

@onready var spriteAnimationPlayer = $AnimationPlayer;
@onready var playerSprite = $AnimatedSprite2D;
@onready var playerRaycasts = get_node("../PlayerRaycasts");
@onready var playerCharacterBody = get_node("..");

func _ready():
	playerSprite.play("push");

func _process(delta):
	updatePlayerAnimation();

## Updates the animation that is currently playing for the player.
func updatePlayerAnimation():
	if (!playerCharacterBody.is_on_floor()):
		playJumpAnimation();
		return;

	if (playerRaycasts.isPlayerGrindingRail()):
		playGrindAnimation();
		return;

	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if (direction == 1):
		playPushAnimation();
	elif (direction == -1):
		playGrindAnimation();
	else:
		playIdleAnimation();

## Playes the On Hit animation for the player.
func playOnHitAnimation():
	# just play the default animation on the animation player since there
	# is only hit on hit animation right now.
	spriteAnimationPlayer.play("FlashOnDamage");

func playIdleAnimation():
	playerSprite.play("default");

func playPushAnimation():
	playerSprite.play("push");

func playGrindAnimation():
	playerSprite.play("grind");

func playJumpAnimation():
	playerSprite.play("jump");