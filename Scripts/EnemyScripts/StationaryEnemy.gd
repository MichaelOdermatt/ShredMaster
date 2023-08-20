extends "res://Scripts/EnemyScripts/EnemyBase.gd"

const halfOfSpriteWidth: int = 7;
const enemyResetPos: Vector2 = Vector2(136, 120);

var enemySpeedX: int;

func _ready():
	enemySpeedX = globals.currentBaseSpeed;
	# Set initial enemy speed
	movementVector = Vector2(-enemySpeedX, 0);
	enemySprite.play("default");

func _physics_process(delta):
	_moveEnemy(delta, halfOfSpriteWidth);

func resetEnemyPosition():
	_resetEnemyPositionAndSpeedVariables(enemyResetPos, enemySpeedX);
