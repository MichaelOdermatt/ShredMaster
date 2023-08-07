extends Node2D

@onready var globals = get_node("/root/Globals");
@onready var timer = $Timer;

var counter: float = 0;

func _ready():
	timer.timeout.connect(increaseSpeeds);

func increaseSpeeds():
	globals.railSpeed = clamp(globals.railSpeed + 3, globals.MIN_BASE_SPEED, globals.MAX_BASE_SPEED);
	globals.coinSpeed = clamp(globals.coinSpeed + 3, globals.MIN_BASE_SPEED, globals.MAX_BASE_SPEED);
	globals.basicEnemySpeed = clamp(globals.basicEnemySpeed + 3, globals.MIN_BASIC_ENEMY_SPEED, globals.MAX_BASIC_ENEMY_SPEED);
	globals.flyingEnemySpeed = clamp(globals.flyingEnemySpeed + 3, globals.MIN_FLYING_ENEMY_SPEED, globals.MAX_FLYING_ENEMY_SPEED);