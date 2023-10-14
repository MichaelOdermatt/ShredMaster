extends Control

const TWEEN_RANGE = 3;
const TWEEN_TIME = 1.5;

@onready var shredText = $Shred;

var shredTextTween: Tween;
var tweenValues: Array;

func _ready():
	tweenValues = [shredText.position.y + TWEEN_RANGE, shredText.position.y - TWEEN_RANGE]
	shredText.position.y = tweenValues[0];
	startShredTextTween();
 
## Starts the tween animation for the Shred text
func startShredTextTween():
	shredTextTween = get_tree().create_tween();
	shredTextTween.tween_property(
		shredText, 
		'position:y', 
		tweenValues[1], 
		TWEEN_TIME
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT);
	shredTextTween.tween_callback(onShredTextTweenComplete);

## Used to look the Shred text animation.
func onShredTextTweenComplete():
	tweenValues.reverse();
	startShredTextTween();
