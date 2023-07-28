extends Node2D

@onready var enemyManager = get_node("../EnemyManager");
@onready var railManager = get_node("../RailManager");
@onready var playerHealth = $PlayerHealth;
@onready var playerMovement = $CharacterBody;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);
	railManager.player_on_rail.connect(_when_player_enters_rail);
	railManager.player_off_rail.connect(_when_player_leaves_rail);

## Destroys the player, ending the game.
func destroyPlayer():
	queue_free();

func _on_player_hit():
	playerHealth.decreaseHealth();

func _when_player_enters_rail():
	print_debug("player is on rail")
	playerMovement.enterRailMode();

func _when_player_leaves_rail():
	print_debug("player is off rail")
	playerMovement.leaveRailMode();
