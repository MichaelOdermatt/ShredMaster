extends TextureRect

const heartSpriteWidth: int = 9;

## Removes one of the hearts from the UI.
func removeHeart():
	var width = custom_minimum_size.x;
	var height = custom_minimum_size.y;
	var newWidth = clamp(width - heartSpriteWidth, 0, width)
	
	custom_minimum_size = Vector2(newWidth, height);
