extends Node2D

const SCREEN_WIDTH = 128;
const FINAL_SPRITE_OFFSET = -448;

@onready var sprite = $Sprite2D;
@onready var nextSpriteTimer = $NextSpriteTimer;

func _ready():
	nextSpriteTimer.timeout.connect(nextSprite);

## Starts the next sprite timer, and updates the wait time to be half a second.
func startNextSpriteTimer():
	nextSpriteTimer.start();
	nextSpriteTimer.wait_time = 0.5;

## Shifts the sprite to show the next frame if it sprite is currently visible.
## If the sprite is not visible it sets the visible property to true.
func nextSprite():
	if (sprite.offset.x <= FINAL_SPRITE_OFFSET):
		nextSpriteTimer.stop();

	if (!sprite.visible):
		sprite.visible = true;
	else:
		sprite.offset.x -= SCREEN_WIDTH;
