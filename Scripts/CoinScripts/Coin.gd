extends Area2D

## Half of the sprites with in pixels
const halfOfSpriteWidth: int = 4
const coinResetPos: Vector2 = Vector2(136, 96);

@onready var globals = get_node("/root/Globals");

signal coin_off_screen();

@export var coinAltitudeMin: int;
@export var coinAltitudeMax: int;
var movementVector: Vector2;
## true if the coin has moved off the screen
var isOffScreen: bool = false;

func _ready():
	getCoinSpeed();

func _physics_process(delta):
	moveCoin(delta);

## Moves the coin while it is not off the screen.
## Once it is off the screen emit a signal to the coin manager.
func moveCoin(delta):
	if (isOffScreen):
		return;

	translate(movementVector * delta);
	# don't mark the coin as off screen until it is past half its width and
	# a few extra pixels to ensure its collider is completely off the screen
	if (transform.origin.x < -(halfOfSpriteWidth + 5)):
		isOffScreen = true;
		emit_signal("coin_off_screen");
	
## Resets the coin's position to its starting position
func resetCoinPosition():
	isOffScreen = false;
	transform.origin = coinResetPos;
	transform.origin.y = randi_range(coinAltitudeMin, coinAltitudeMax);
	getCoinSpeed();

## To be used in place of destroying the object.
func moveCoinOffScreen():
	transform.origin.x = -(halfOfSpriteWidth + 5);

## Updates the movementVector variable with the coin speed from globals.
func getCoinSpeed():
	movementVector = Vector2(-globals.currentBaseSpeed, 0);