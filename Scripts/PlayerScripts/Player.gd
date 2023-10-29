extends Node2D

## The score the player gets every frame while grinding a rail.
const PLAYER_GRIND_SCORE = 1;
const PLAYER_PICKUP_COIN_SCORE = 100;

@onready var enemyManager = get_node("../EnemyManager");
@onready var railManager = get_node("../RailManager");
@onready var coinManager = get_node("../CoinManager");
@onready var ui = get_node("../UI");
@onready var playerStats = $PlayerStats;
@onready var playerMovement = $CharacterBody;
@onready var playerSprite = $CharacterBody/PlayerSprite;
@onready var invincibilityTimer = $InvincibilityTimer;
@onready var playerRaycasts = $CharacterBody/PlayerRaycasts;
@onready var playerParticleEffects = $PlayerParticleEffects
@onready var playerSounds = $PlayerSounds;
@onready var playerInput = $PlayerInput;
@onready var UISounds = get_node("../UI/UISounds");
## I use this Area2D node for the area_entered event that runs on collisions with the floor
@onready var floorCollisionArea = $CharacterBody/FloorCollisionArea;
@onready var kaput = get_node("../UI/Kaput");

## Bool used to keep track if the player is currently invincible.
var isPlayerInvincible: bool = false;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);
	coinManager.player_pickup.connect(_on_player_pickup_coin);
	invincibilityTimer.timeout.connect(_on_invincibilityTimer_timeout);
	floorCollisionArea.area_entered.connect(_on_player_floor_collision);
	playerInput.movement_key_just_pressed_or_released.connect(_on_movement_key_just_pressed_or_released);
	playerInput.jump_key_just_pressed.connect(_on_jump_key_just_pressed);

func _process(delta):
	var isPlayerOnFloor = playerMovement.is_on_floor();
	var isGrindingRail = playerRaycasts.isPlayerGrindingRail();
	if (isGrindingRail):
		playerSounds.playRailGrindLoopWithImpact();
		playerParticleEffects.startEmittingSparkParticles(playerMovement.transform.origin);
		playerSprite.playGrindAnimation();
		addPointsToScore(PLAYER_GRIND_SCORE)
	elif (!isPlayerOnFloor):
		playerSounds.stopRollLoops();
		playerSounds.stopRailGrindLoop();
		playerParticleEffects.stopEmittingSparkParticles();

## Destroys the player, ending the game.
func destroyPlayer():
	playerParticleEffects.CreateInstanceAndEmitCloudParticles(playerMovement.transform.origin);
	playerParticleEffects.CreateInstanceAndEmitFlyingSkateboardParticles(playerMovement.transform.origin);
	playerParticleEffects.CreateInstanceAndEmitFlyingPlayerParticles(playerMovement.transform.origin);
	kaput.startNextSpriteTimer();
	queue_free();

## Adds specified amount of points to the player score.
func addPointsToScore(points: int):
	var newScore = playerStats.addPoints(points);
	ui.updatePlayerScore(str(newScore));

func _on_player_hit():
	if (isPlayerInvincible):
		return;

	isPlayerInvincible = true;
	ui.removePlayerHeart();
	playerSprite.playOnHitAnimation();
	invincibilityTimer.start();
	var newHealth = playerStats.decreaseHealth();
	if (newHealth != 0):
		playerSounds.playHitSound();
	else:
		UISounds.playDeathSound();
		destroyPlayer();

func _on_player_pickup_coin():
	addPointsToScore(PLAYER_PICKUP_COIN_SCORE);
	playerSounds.playPopCanOpenSound();

func _on_invincibilityTimer_timeout():
	isPlayerInvincible = false;

func _on_player_floor_collision(area: Area2D):
	# Since the floor collision area only masks for the map boundaries we dont need to bother checking the colliding area
	playerParticleEffects.emitImpactParticles(playerMovement.transform.origin);
	playerSounds.playConcreteImpactSound();
	var direction = playerInput.getMovementInputDirection();
	playerSounds.playRollLoops(direction);

func _on_movement_key_just_pressed_or_released():
	var isPlayerOnFloor = playerMovement.is_on_floor();
	var direction = playerInput.getMovementInputDirection();
	var isGrindingRail = playerRaycasts.isPlayerGrindingRail();
	if isPlayerOnFloor && !isGrindingRail:
		playerSounds.playRollLoops(direction);

func _on_jump_key_just_pressed():
	var isPlayerOnFloor = playerMovement.is_on_floor();
	if isPlayerOnFloor:
		playerSounds.playConcreteJumpSound();
