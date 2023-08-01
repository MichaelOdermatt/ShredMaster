extends Area2D

## Half of the sprites with in pixels
const halfOfSpriteWidth: int = 4
const coinResetPos: Vector2 = Vector2(136, 96);

signal coin_off_screen();

@export var coinAltitudeMin: int;
@export var coinAltitudeMax: int;
@export var movementSpeed: int;
var movementVector: Vector2;
## true if the coin has moved off the screen
var isOffScreen: bool = false;

func _ready():
	movementVector = Vector2(-movementSpeed, 0);

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

## To be used in place of destroying the object.
func moveCoinOffScreen():
	transform.origin.x = -(halfOfSpriteWidth + 5);