extends Node2D

## The score the player gets every frame while grinding a rail.
const PLAYER_GRIND_SCORE = 1;

@onready var enemyManager = get_node("../EnemyManager");
@onready var railManager = get_node("../RailManager");
@onready var ui = get_node("../UI");
@onready var playerHealth = $PlayerHealth;
@onready var playerScore = $PlayerScore;
@onready var playerMovement = $CharacterBody;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);

func _process(delta):
	if (playerMovement.isPlayerGrindingRail()):
		addPointsToScore(PLAYER_GRIND_SCORE)

## Destroys the player, ending the game.
func destroyPlayer():
	queue_free();

func _on_player_hit():
	playerHealth.decreaseHealth();

func addPointsToScore(points: int):
	playerScore.addPoints(points);
	ui.updatePlayerScore(str(playerScore.getScore()));
