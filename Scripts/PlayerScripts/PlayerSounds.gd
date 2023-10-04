extends Node2D

const AUDIO_FADE_IN_DURATION: float = 0.1;
const AUDIO_FADE_OUT_DURATION: float = 0.25;
const AUDIO_VOLUME_MIN: float = -30;
const AUDIO_VOLUME_MAX: float = 0;

var concreteImpact1 = preload("res://Sounds/ConcreteImpact/ConcreteImpact1.wav");
var concreteImpact2 = preload("res://Sounds/ConcreteImpact/ConcreteImpact2.wav");
var concreteImpact3 = preload("res://Sounds/ConcreteImpact/ConcreteImpact3.wav");
var concreteJump1 = preload("res://Sounds/ConcreteJump/ConcreteJump1.wav");
var concreteJump2 = preload("res://Sounds/ConcreteJump/ConcreteJump2.wav");
var concreteJump3 = preload("res://Sounds/ConcreteJump/ConcreteJump3.wav");
var popCanOpen1 = preload("res://Sounds/PopCanOpen/PopCanOpen1.wav");
var popCanOpen2 = preload("res://Sounds/PopCanOpen/PopCanOpen2.wav");

@onready var railGrindAudioPlayer = $RailGrindAudioPlayer;
@onready var cruiseAudioPlayer = $CruiseAudioPlayer;
@onready var pushAudioPlayer = $PushAudioPlayer;
@onready var stallAudioPlayer = $StallAudioPlayer;
@onready var popCanAudioPlayer = $PopCanAudioPlayer;
@onready var jumpAudioPlayer = $JumpAudioPlayer;
@onready var impactAudioPlayer = $ImpactAudioPlayer;

var concreteImpactSounds = [concreteImpact1, concreteImpact2, concreteImpact3];
var concreteJumpSounds = [concreteJump1, concreteJump2, concreteJump3];
var popCanOpenSounds = [popCanOpen1, popCanOpen2];

var fadeInCruiseTween: Tween;
var fadeOutCruiseTween: Tween;
var fadeInPushTween: Tween;
var fadeOutPushTween: Tween;
var fadeInStallTween: Tween;
var fadeOutStallTween: Tween;

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

## Plays the rail grind sound loop.
func playRailGrindLoop():
	if (railGrindAudioPlayer.playing):
		return;
		
	railGrindAudioPlayer.play();

## Plays the cruise sound loop.
func playCruiseLoop(fade: bool = false):
	if (cruiseAudioPlayer.playing):
		return;
	
	if fade && !isCurrentlyTweening(fadeInCruiseTween):
		fadeInCruiseTween = createFadeInTween(cruiseAudioPlayer);
	elif !fade:
		cruiseAudioPlayer.play();
	
## Plays the push sound loop.
func playPushLoop(fade: bool = false):
	if (pushAudioPlayer.playing):
		return;
	
	if fade && !isCurrentlyTweening(fadeInPushTween):
		fadeInPushTween = createFadeInTween(pushAudioPlayer);
	elif !fade:
		pushAudioPlayer.play();
		
## Plays the stall sound loop.
func playStallLoop(fade: bool = false):
	if (stallAudioPlayer.playing):
		return;
	
	if fade && !isCurrentlyTweening(fadeInStallTween):
		fadeInStallTween = createFadeInTween(stallAudioPlayer);
	elif !fade:
		stallAudioPlayer.play();
		
## Plays the rail grind sound loop.
func stopRailGrindLoop():
	railGrindAudioPlayer.stop();

## Stops the cruise sound loop.
func stopCruiseLoop(fade: bool = false):
	if (!cruiseAudioPlayer.playing):
		return;
	
	if fade && !isCurrentlyTweening(fadeOutCruiseTween):
		
		fadeOutCruiseTween = createFadeOutTween(cruiseAudioPlayer);
	elif !fade:
		cruiseAudioPlayer.stop();
	
## Stops the push sound loop.
func stopPushLoop(fade: bool = false):
	if (!pushAudioPlayer.playing):
		return;
	
	if fade && !isCurrentlyTweening(fadeOutPushTween):
		fadeOutPushTween = createFadeOutTween(pushAudioPlayer);
	elif !fade:
		pushAudioPlayer.stop();
		
## Stops the stall sound loop abruptly.
func stopStallLoop(fade: bool = false):
	if (!stallAudioPlayer.playing):
		return;
	
	if fade && !isCurrentlyTweening(fadeOutStallTween):
		fadeOutStallTween = createFadeOutTween(stallAudioPlayer);
	elif !fade:
		stallAudioPlayer.stop();

## Randomly selects a sound from the array and plays it through the given audio player.
func playRandomSoundFromArray(arrayOfSounds: Array, audioPlayer: AudioStreamPlayer):
	randomize();
	var soundToPlay = arrayOfSounds[randi_range(0, len(arrayOfSounds) - 1)];
	audioPlayer.stream = soundToPlay;
	audioPlayer.play();

## Creates a fade in tween for the audioPlayer's volume.
func createFadeInTween(audioPlayer: AudioStreamPlayer) -> Tween:
	var fadeTween = create_tween();
	
	fadeTween.tween_property(
		audioPlayer, 
		"volume_db", 
		AUDIO_VOLUME_MAX, 
		AUDIO_FADE_IN_DURATION
	).from(AUDIO_VOLUME_MIN);
	audioPlayer.play();
	
	return fadeTween;

## Creates a fade out tween for the audioPlayer's volume.
func createFadeOutTween(audioPlayer: AudioStreamPlayer) -> Tween:
	var fadeTween = get_tree().create_tween();
	
	fadeTween.tween_property(
		audioPlayer, 
		"volume_db", 
		AUDIO_VOLUME_MIN, 
		AUDIO_FADE_OUT_DURATION
	).from_current();
	
	fadeTween.tween_callback(audioPlayer.stop);
	return fadeTween;

func isCurrentlyTweening(tween: Tween) -> bool:
	return tween != null && tween.is_running();
