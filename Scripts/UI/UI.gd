extends CanvasLayer

@onready var healthUI = $HBoxContainer/Container/Health;
@onready var scoreCounter = $MarginContainer/HBoxContainer/ScoreCounter;

## Sets the displayed score to the given string.
func updatePlayerScore(score: String):
	scoreCounter.text = score;

## Removes one of the player hearts from the UI.
func removePlayerHeart():
	healthUI.removeHeart();
