extends Node2D

@onready var player = get_node("..");
@export var playerHealth: int;

## Decreases the playerHealth value by one. Returns the new health value.
func decreaseHealth() -> int:
	playerHealth -= 1;
	
	return playerHealth;
