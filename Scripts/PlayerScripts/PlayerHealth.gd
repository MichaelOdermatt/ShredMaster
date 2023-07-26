extends Node2D

@export var playerHealth: int;

## Decreases the playerHealth value by one.
func decreaseHealth():
	playerHealth -= 1;