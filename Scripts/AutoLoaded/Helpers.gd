extends Node

@onready var globals = get_node("/root/Globals");

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
		globals.AUDIO_VOLUME_MAX, 
		globals.AUDIO_FADE_IN_DURATION
	).from(globals.AUDIO_VOLUME_MIN);
	audioPlayer.play();
	
	return fadeTween;

## Creates a fade out tween for the audioPlayer's volume.
func createFadeOutTween(audioPlayer: AudioStreamPlayer) -> Tween:
	var fadeTween = get_tree().create_tween();
	
	fadeTween.tween_property(
		audioPlayer, 
		"volume_db", 
		globals.AUDIO_VOLUME_MIN, 
		globals.AUDIO_FADE_OUT_DURATION
	).from_current();
	
	fadeTween.tween_callback(audioPlayer.stop);
	return fadeTween;

func killTweenIfNotNull(tween: Tween):
	if (tween != null):
		tween.kill();