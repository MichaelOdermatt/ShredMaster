extends Node2D

@onready var player = get_node("..");
@export var playerHealth: int;

## Decreases the playerHealth value by one.
func decreaseHealth():
	playerHealth -= 1;
	if (playerHealth <= 0):
		player.destroyPlayer();