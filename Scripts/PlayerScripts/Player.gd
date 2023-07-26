extends Node2D

@onready var enemyManager = get_node("../EnemyManager");
@onready var playerHealth = $PlayerHealth;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);

func _on_player_hit():
	playerHealth.decreaseHealth();
