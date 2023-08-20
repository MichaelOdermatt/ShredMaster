extends "res://Scripts/EnemyScripts/EnemyBase.gd"

const halfOfSpriteWidth: int = 7;
const enemyResetPos: Vector2 = Vector2(136, 120);

@export var enemyAltitudeMax: int;
@export var enemyAltitudeMin: int;

var enemySpeedX: int;

func _ready():
	enemySpeedX = globals.flyingEnemySpeed;
	# Set initial enemy speed
	movementVector = Vector2(-enemySpeedX, 0);

func _physics_process(delta):
	_moveEnemy(delta, halfOfSpriteWidth);

func resetEnemyPosition():
	_resetEnemyPositionAndSpeedVariables(enemyResetPos, enemySpeedX);
	randomize();
	transform.origin.y = randi_range(enemyAltitudeMin, enemyAltitudeMax);
