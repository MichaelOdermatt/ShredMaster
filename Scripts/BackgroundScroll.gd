extends ParallaxBackground

@onready var globals = get_node("/root/Globals");
@onready var parallaxForeground = $ParallaxForeground

func _process(delta):
	# scrolls the background
	var scrollAmount = globals.currentBaseSpeed * delta;
	scroll_offset.x -= scrollAmount;
	parallaxForeground.scroll_offset.x -= scrollAmount;
