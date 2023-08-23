extends "res://Scripts/EnemyScripts/EnemyBase.gd"

const halfOfSpriteWidth: int = 7;
const enemyResetPos: Vector2 = Vector2(136, 120);

@export var enemyAltitudeMax: int;
@export var enemyAltitudeMin: int;

func _ready():
	# Set initial enemy speed
	movementVector = Vector2(-globals.flyingEnemySpeed, 0);
	enemySprite.play("default")

func _physics_process(delta):
	_moveEnemy(delta, halfOfSpriteWidth);

func resetEnemyPosition():
	_resetEnemyPositionAndSpeedVariables(enemyResetPos, globals.flyingEnemySpeed);
	randomize();
	transform.origin.y = randi_range(enemyAltitudeMin, enemyAltitudeMax);
