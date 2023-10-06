extends Node2D

@onready var deathAudioPlayer = $DeathAudioPlayer;

## Plays the death sound.
func playDeathSound():
	deathAudioPlayer.play();
