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
@onready var spriteAnimationPlayer = $CharacterBody/PlayerSprite/AnimationPlayer;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);
	coinManager.player_pickup.connect(_on_player_pickup_coin);

func _process(delta):
	if (playerMovement.isPlayerGrindingRail()):
		addPointsToScore(PLAYER_GRIND_SCORE)

## Destroys the player, ending the game.
func destroyPlayer():
	queue_free();

## Adds specified amount of points to the player score.
func addPointsToScore(points: int):
	playerScore.addPoints(points);
	ui.updatePlayerScore(str(playerScore.getScore()));

## Playes the On Hit animation for the player.
func playOnHitAnimation():
	# just play the default animation on the animation player since there
	# is only hit on hit animation right now.
	spriteAnimationPlayer.play("FlashOnDamage");

func _on_player_hit():
	playerHealth.decreaseHealth();
	playOnHitAnimation();

func _on_player_pickup_coin():
	addPointsToScore(PLAYER_PICKUP_COIN_SCORE);
