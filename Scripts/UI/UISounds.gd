extends Node2D

@onready var deathAudioPlayer = $DeathAudioPlayer;
@onready var kaputAudioPlayer = $KaputAudioPlayer;

## Plays the death sound.
func playDeathSound():
	deathAudioPlayer.play();

func playKaputSound():
	if (kaputAudioPlayer.playing):
		return;
	
	kaputAudioPlayer.play();
