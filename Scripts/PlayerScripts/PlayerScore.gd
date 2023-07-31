extends Node2D

var score: int = 0;

func addPoints(points: int):
	score += points;

func getScore() -> int:
	return score;