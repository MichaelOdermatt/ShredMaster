extends Node2D

## The score the player gets every frame while grinding a rail.
const PLAYER_GRIND_SCORE = 1;
const PLAYER_PICKUP_COIN_SCORE = 100;

@onready var enemyManager = get_node("../EnemyManager");
@onready var railManager = get_node("../RailManager");
@onready var coinManager = get_node("../CoinManager");
@onready var ui = get_node("../UI");
@onready var playerHealth = $PlayerHealth;
@onready var playerScore = $PlayerScore;
@onready var playerMovement = $CharacterBody;
@onready var playerSprite = $CharacterBody/PlayerSprite;
@onready var invincibilityTimer = $InvincibilityTimer;
@onready var playerRaycasts = $CharacterBody/PlayerRaycasts;
@onready var playerParticleEffects = $PlayerParticleEffects
@onready var floorCollisionArea = $CharacterBody/FloorCollisionArea;

## Bool used to keep track if the player is currently invincible.
var isPlayerInvincible: bool = false;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);
	coinManager.player_pickup.connect(_on_player_pickup_coin);
	invincibilityTimer.timeout.connect(_on_invincibilityTimer_timeout);
	floorCollisionArea.area_entered.connect(_on_player_floor_collision);

func _process(delta):
	if (playerRaycasts.isPlayerGrindingRail()):
		addPointsToScore(PLAYER_GRIND_SCORE)

## Destroys the player, ending the game.
func destroyPlayer():
	queue_free();

## Adds specified amount of points to the player score.
func addPointsToScore(points: int):
	playerScore.addPoints(points);
	ui.updatePlayerScore(str(playerScore.getScore()));

func _on_player_hit():
	if (isPlayerInvincible):
		return;

	isPlayerInvincible = true;
	ui.removePlayerHeart();
	playerHealth.decreaseHealth();
	playerSprite.playOnHitAnimation();
	invincibilityTimer.start();

func _on_player_pickup_coin():
	addPointsToScore(PLAYER_PICKUP_COIN_SCORE);

func _on_invincibilityTimer_timeout():
	isPlayerInvincible = false;

func _on_player_floor_collision(area: Area2D):
	# Since the floor collision area only masks for the map boundaries we dont need to bother checking the colliding area
	playerParticleEffects.emitCloudParticles(playerMovement.transform.origin);