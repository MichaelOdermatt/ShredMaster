extends CharacterBody2D

const Coin = preload("res://Scripts/CoinScripts/Coin.gd");
## The x position that the rail must be at to be considered off the screen
const offScreenPosition: int = -90;
const railResetPos: Vector2 = Vector2(192, 112);

@onready var globals = get_node("/root/Globals");
@onready var coin = $Coin;

signal rail_off_screen();

@export var railAltitudeMax: int;
@export var railAltitudeMin: int;

var movementVector: Vector2;
## true if the rail has moved off the screen
var isOffScreen: bool = false;

func _ready():
	getRailSpeed();

func _physics_process(delta):
	moveRail();

## Moves the rail while it is not off the screen.
## Once it is off the screen emit a signal to the rail manager.
func moveRail():
	if (isOffScreen):
		return;

	velocity = movementVector;
	move_and_slide()

	# don't mark the rail as off screen until it is past half its width and
	# a few extra pixels to ensure its collider is completely off the screen
	if (transform.origin.x < offScreenPosition):
		isOffScreen = true;
		emit_signal("rail_off_screen");
	
## Resets the rails's position to its starting position
func resetRailPosition():
	isOffScreen = false;
	transform.origin = railResetPos;
	randomize();
	transform.origin.y = randi_range(railAltitudeMin, railAltitudeMax);
	getRailSpeed();
	coin.enable();

## Updates the movementVector variable with the rail speed from globals.
func getRailSpeed():
	movementVector = Vector2(-globals.currentBaseSpeed, 0);

func getCoin()-> Coin:
	return coin;

## Function which returns the script's type as a string.
func get_type():
	return "Rail";
