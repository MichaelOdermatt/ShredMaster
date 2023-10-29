extends Node2D

var metalImpact = preload("res://Sounds/MetalImpact.wav");
var concreteImpact1 = preload("res://Sounds/ConcreteImpact/ConcreteImpact1.wav");
var concreteImpact2 = preload("res://Sounds/ConcreteImpact/ConcreteImpact2.wav");
var concreteImpact3 = preload("res://Sounds/ConcreteImpact/ConcreteImpact3.wav");
var concreteJump1 = preload("res://Sounds/ConcreteJump/ConcreteJump1.wav");
var concreteJump2 = preload("res://Sounds/ConcreteJump/ConcreteJump2.wav");
var concreteJump3 = preload("res://Sounds/ConcreteJump/ConcreteJump3.wav");
var hit1 = preload("res://Sounds/HitSounds/HitSound1.wav");
var hit2 = preload("res://Sounds/HitSounds/HitSound2.wav");
var hit3 = preload("res://Sounds/HitSounds/HitSound3.wav");
var popCanOpen1 = preload("res://Sounds/PopCanOpen/PopCanOpen1.wav");
var popCanOpen2 = preload("res://Sounds/PopCanOpen/PopCanOpen2.wav");

@onready var helpers = get_node("/root/Helpers");
@onready var railGrindAudioPlayer = $RailGrindAudioPlayer;
@onready var cruiseAudioPlayer = $CruiseAudioPlayer;
@onready var pushAudioPlayer = $PushAudioPlayer;
@onready var stallAudioPlayer = $StallAudioPlayer;
@onready var popCanAudioPlayer = $PopCanAudioPlayer;
@onready var jumpAudioPlayer = $JumpAudioPlayer;
@onready var impactAudioPlayer = $ImpactAudioPlayer;
@onready var hitAudioPlayer = $HitAudioPlayer;

var concreteImpactSounds = [concreteImpact1, concreteImpact2, concreteImpact3];
var concreteJumpSounds = [concreteJump1, concreteJump2, concreteJump3];
var popCanOpenSounds = [popCanOpen1, popCanOpen2];
var hitSounds = [hit1, hit2, hit3];

var fadeCruiseTween: Tween;
var fadePushTween: Tween;
var fadeStallTween: Tween;

## Plays the metal impact sound.
func playMetalImpactSound():
	if (impactAudioPlayer.playing):
		return;
	
	impactAudioPlayer.stream = metalImpact;
	impactAudioPlayer.play();

## Randomly selects and plays one of the hit sounds.
func playHitSound():
	if (hitAudioPlayer.playing):
		return;
		
	helpers.playRandomSoundFromArray(hitSounds, hitAudioPlayer);	

## Randomly selects and plays one of the concrete impact sounds.
func playConcreteImpactSound():
	if (impactAudioPlayer.playing):
		return;
		
	helpers.playRandomSoundFromArray(concreteImpactSounds, impactAudioPlayer);	

## Randomly selects and plays one of the concrete jump sounds.
func playConcreteJumpSound():
	if (jumpAudioPlayer.playing):
		return;
	
	helpers.playRandomSoundFromArray(concreteJumpSounds, jumpAudioPlayer);	

## Randomly selects and plays one of the pop can opening sounds.
func playPopCanOpenSound():
	if (popCanAudioPlayer.playing):
		return;
		
	helpers.playRandomSoundFromArray(popCanOpenSounds, popCanAudioPlayer);	

## Plays either the cruise, or push loop depending on the players movement direction.
func playRollLoops(direction: int):
	if direction == 1:
		stopCruiseLoop(true);
		stopStallLoop(true);
		playPushLoop(true);
	elif direction == -1:
		stopPushLoop(true);
		stopCruiseLoop(true);
		playStallLoop(true);
	else:
		stopPushLoop(true);
		stopStallLoop(true);
		playCruiseLoop(true);

## Stops the cruise, and push audio loops.
func stopRollLoops():
	stopCruiseLoop();
	stopPushLoop();
	stopStallLoop();
	stopRailGrindLoop();

## Plays the one shot metal impact sound then starts playing the rail grind sound loop.
func playRailGrindLoopWithImpact():
	if (railGrindAudioPlayer.playing):
		return;
	
	playMetalImpactSound();
	railGrindAudioPlayer.play();

## Plays the rail grind sound loop.
func stopRailGrindLoop():
	railGrindAudioPlayer.stop();

## Plays the cruise sound loop.
func playCruiseLoop(fade: bool = false):
	if fade:
		helpers.killTweenIfNotNull(fadeCruiseTween);
		fadeCruiseTween = helpers.createFadeInTween(cruiseAudioPlayer);
	else:
		cruiseAudioPlayer.play();
	
## Plays the push sound loop.
func playPushLoop(fade: bool = false):
	if fade:
		helpers.killTweenIfNotNull(fadePushTween);
		fadePushTween = helpers.createFadeInTween(pushAudioPlayer);
	else:
		pushAudioPlayer.play();
		
## Plays the stall sound loop.
func playStallLoop(fade: bool = false):
	if fade:
		helpers.killTweenIfNotNull(fadeStallTween);
		fadeStallTween = helpers.createFadeInTween(stallAudioPlayer);
	else:
		stallAudioPlayer.play();

## Stops the cruise sound loop.
func stopCruiseLoop(fade: bool = false):
	if fade:
		helpers.killTweenIfNotNull(fadeCruiseTween);
		fadeCruiseTween = helpers.createFadeOutTween(cruiseAudioPlayer);
	else:
		cruiseAudioPlayer.stop();
	
## Stops the push sound loop.
func stopPushLoop(fade: bool = false):
	if fade:
		helpers.killTweenIfNotNull(fadePushTween);
		fadePushTween = helpers.createFadeOutTween(pushAudioPlayer);
	else:
		pushAudioPlayer.stop();
		
## Stops the stall sound loop abruptly.
func stopStallLoop(fade: bool = false):
	if fade:
		helpers.killTweenIfNotNull(fadeStallTween);
		fadeStallTween = helpers.createFadeOutTween(stallAudioPlayer);
	else:
		stallAudioPlayer.stop();
