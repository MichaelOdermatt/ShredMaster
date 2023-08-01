extends Node2D

signal player_pickup();

@export var coinSpawnIntervalMax: int;
@export var coinSpawnIntervalMin: int;

@onready var coin = $Coin;
## Timer used to create a delay between the time the basic enemy leaves the 
## screen and when it re-appears
@onready var coinTimer = $Coin/Timer;

func _ready():
	# setup funcs for the basic enemy
	coin.coin_off_screen.connect(coinOffScreen);
	coinTimer.timeout.connect(resetCoin);
	coin.body_entered.connect(_on_coin_hit);

## Setup and start a cooldown timer for the coins's respawn.
func coinOffScreen():
	randomize();
	coinTimer.wait_time = randi_range(coinSpawnIntervalMin, coinSpawnIntervalMax);
	coinTimer.start();

## Reset the coin's position.
func resetCoin():
	coin.resetCoinPosition();

func _on_coin_hit(body: Node2D):
	# no need to check if the colliding body is the player since the coin
	# only has a collision mask enabled on the players collision layer.
	coin.moveCoinOffScreen();
	emit_signal("player_pickup")
