extends Node2D

@onready var popCanAudioPlayer = $PopCanAudioPlayer;
@onready var jumpAudioPlayer = $JumpAudioPlayer;
@onready var impactAudioPlayer = $ImpactAudioPlayer;
var concreteImpact1 = preload("res://Sounds/ConcreteImpact/ConcreteImpact1.wav");
var concreteImpact2 = preload("res://Sounds/ConcreteImpact/ConcreteImpact2.wav");
var concreteImpact3 = preload("res://Sounds/ConcreteImpact/ConcreteImpact3.wav");
var concreteJump1 = preload("res://Sounds/ConcreteJump/ConcreteJump1.wav");
var concreteJump2 = preload("res://Sounds/ConcreteJump/ConcreteJump2.wav");
var concreteJump3 = preload("res://Sounds/ConcreteJump/ConcreteJump3.wav");
var popCanOpen1 = preload("res://Sounds/PopCanOpen/PopCanOpen1.wav");
var popCanOpen2 = preload("res://Sounds/PopCanOpen/PopCanOpen2.wav");

var concreteImpactSounds = [concreteImpact1, concreteImpact2, concreteImpact3];
var concreteJumpSounds = [concreteJump1, concreteJump2, concreteJump3];
var popCanOpenSounds = [popCanOpen1, popCanOpen2];

## Randomly selects and plays one of the concrete impact sounds.
func playConcreteImpactSound():
	if (impactAudioPlayer.playing):
		return;
		
	playRandomSoundFromArray(concreteImpactSounds, impactAudioPlayer);	

## Randomly selects and plays one of the concrete jump sounds.
func playConcreteJumpSound():
	if (jumpAudioPlayer.playing):
		return;
	
	playRandomSoundFromArray(concreteJumpSounds, jumpAudioPlayer);	

## Randomly selects and plays one of the pop can opening sounds.
func playPopCanOpenSound():
	if (popCanAudioPlayer.playing):
		return;
		
	playRandomSoundFromArray(popCanOpenSounds, popCanAudioPlayer);	
	
func playRandomSoundFromArray(arrayOfSounds: Array, audioPlayer: AudioStreamPlayer):
	randomize();
	var soundToPlay = arrayOfSounds[randi_range(0, len(arrayOfSounds) - 1)];
	audioPlayer.stream = soundToPlay;
	audioPlayer.play();
