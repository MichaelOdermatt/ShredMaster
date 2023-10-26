extends Node2D

var playerHealth: int;
var playerScore: int = 0;

## Decreases the playerHealth value by one. Returns the new health value.
func decreaseHealth() -> int:
	playerHealth -= 1;
	
	return playerHealth;

## Adds points to the player's score. Returns the new score value.
func addPoints(points: int) -> int:
	playerScore += points;

	return playerScore;
