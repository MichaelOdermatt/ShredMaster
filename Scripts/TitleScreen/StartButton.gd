extends Label

@onready var bounds = Rect2(position, size);
@onready var onHoverColor: Color = Color("d4804d");
@onready var normalColor: Color = Color("e3cfb4");
@onready var musicController = $"/root/MusicController";

func _ready():
	mouse_entered.connect(_on_mouse_entered);
	mouse_exited.connect(_on_mouse_exited);

func _input(event):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		if (bounds.has_point(event.position)):
			onStartClicked();

func onStartClicked():
	musicController.startPlayingGameplayMusic();
	get_tree().change_scene_to_file("res://Scenes/main.tscn");

func _on_mouse_entered():
	add_theme_color_override("font_color", onHoverColor);

func _on_mouse_exited():
	add_theme_color_override("font_color", normalColor);
