extends TextureRect

const heartSpriteWidth: int = 9;

## Removes one of the hearts from the UI.
func removeHeart():
	var width = get_size().x;
	var height = get_size().y;
	var newWidth = clamp(width - heartSpriteWidth, 0, width)
	
	set_size(Vector2(newWidth, height));
