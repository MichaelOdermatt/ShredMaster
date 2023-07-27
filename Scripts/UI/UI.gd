extends CanvasLayer

@onready var enemyManager = get_node("../EnemyManager");
@onready var healthUI = $Health;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);

func _on_player_hit():
	healthUI.removeHeart();
