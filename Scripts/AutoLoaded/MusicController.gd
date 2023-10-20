extends Node

@onready var introMusic = preload("res://Sounds/Music/garbidchIntro.wav");
@onready var gameplayMusic = preload("res://Sounds/Music/garbidchLoop.wav");
@onready var musicPlayer = $MusicPlayer;

var playGameplayMusic: bool = false;

func _ready():
	musicPlayer.stream = introMusic;
	musicPlayer.play();
	musicPlayer.finished.connect(_replay_intro_music);
	
## Starts playing the gameplay music after the next loop
func startPlayingGameplayMusic():
	musicPlayer.finished.connect(_play_gameplay_music);
	
## Starts playing the gameplay music.
func _play_gameplay_music():
	musicPlayer.finished.disconnect(_play_gameplay_music);
	musicPlayer.stream = gameplayMusic;
	musicPlayer.play();

## Starts playing the intro music.
func _replay_intro_music():
	musicPlayer.stream = introMusic;
	musicPlayer.play();
