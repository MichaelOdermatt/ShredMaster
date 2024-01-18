extends "res://Scripts/EnemyScripts/EnemyBase.gd"

const halfOfSpriteWidth: int = 7;
const enemyResetPos: Vector2 = Vector2(136, 120);
const amplitude = 20;
const frequency = 2;

@export var enemyAltitudeMax: int;
@export var enemyAltitudeMin: int;

var time: float = 0.0;

func _ready():
	# Set initial enemy speed
	movementVector = Vector2(-globals.flyingEnemySpeed, 0);
	enemySprite.play("default")

func _physics_process(delta):
	time += delta;
	# Apply the vertical movement 
	movementVector.y = sin(time * frequency) * amplitude;
	_moveEnemy(delta, halfOfSpriteWidth);

func resetEnemyPosition():
	_resetEnemyPositionAndSpeedVariables(enemyResetPos, globals.flyingEnemySpeed);
	randomize();
	transform.origin.y = randi_range(enemyAltitudeMin, enemyAltitudeMax);
