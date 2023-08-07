extends ParallaxBackground

@onready var globals = get_node("/root/Globals");

func _process(delta):
	# scrolls the background
	scroll_offset.x -= globals.currentBaseSpeed * delta;
