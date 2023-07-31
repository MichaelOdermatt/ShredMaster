extends CanvasLayer

@onready var enemyManager = get_node("../EnemyManager");
@onready var healthUI = $HBoxContainer/Container/Health;
@onready var scoreLabel = $HBoxContainer/HBoxContainer/ScoreLabel;

func _ready():
	enemyManager.player_hit.connect(_on_player_hit);

func _on_player_hit():
	healthUI.removeHeart();

func updatePlayerScore(score: String):
	scoreLabel.text = score;
