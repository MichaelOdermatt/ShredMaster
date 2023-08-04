extends CanvasLayer

@onready var healthUI = $HBoxContainer/Container/Health;
@onready var scoreLabel = $HBoxContainer/HBoxContainer/ScoreLabel;

## Sets the displayed score to the given string.
func updatePlayerScore(score: String):
	scoreLabel.text = score;

## Removes one of the player hearts from the UI.
func removePlayerHeart():
	healthUI.removeHeart();
