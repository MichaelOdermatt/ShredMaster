extends ParallaxBackground

@export var scrollSpeed: int;

func _process(delta):
	# scrolls the 
	scroll_offset.x -= scrollSpeed * delta;
