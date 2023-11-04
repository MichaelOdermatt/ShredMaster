extends Node2D

const Coin = preload("res://Scripts/CoinScripts/Coin.gd");

signal player_pickup();

## Adds the player_pickup signal to the coin's body_entered event. So whenever the coin
## is hit. The player_pickup signal will be emitted from the coin manager.
func monitorCoin(coin: Coin):
	coin.body_entered.connect(_on_coin_hit);

func _on_coin_hit(body: Node2D):
	# no need to check if the colliding body is the player since the coin
	# only has a collision mask enabled on the players collision layer.
	emit_signal("player_pickup")
