extends Label

@onready var bounds = Rect2(position, size);
@onready var onHoverColor: Color = Color("6df7c1");

func _ready():
	mouse_entered.connect(_on_mouse_entered);
	mouse_exited.connect(_on_mouse_exited);

func _input(event):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		if (bounds.has_point(event.position)):
			switchToMainScene();

func switchToMainScene():
	get_tree().change_scene_to_file("res://Scenes/main.tscn");

func _on_mouse_entered():
	add_theme_color_override("font_color", onHoverColor);
	add_theme_color_override("font_shadow_color", Color.BLACK);

func _on_mouse_exited():
	remove_theme_color_override("font_color");
	remove_theme_color_override("font_shadow_color");