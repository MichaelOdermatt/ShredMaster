extends Node2D

@onready var enemyManager = get_node("../EnemyManager");
@onready var railManager = get_node("../RailManager");
@onready var playerHealth = $PlayerHealth;
@onready var playerMovement = $CharacterBody;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);

## Destroys the player, ending the game.
func destroyPlayer():
	queue_free();

func _on_player_hit():
	playerHealth.decreaseHealth();
