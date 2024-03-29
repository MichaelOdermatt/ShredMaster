extends Area2D

@onready var sprite = $AnimatedSprite;
@onready var collectCoinParticles = $CollectCoinParticles;

func _ready():
	body_entered.connect(_on_body_entered);
	sprite.play("default");

## Enables and shows the coin
func enable():
	sprite.visible = true;
	set_deferred('monitoring', true);

## Disables and hides the coin, then plays the particle effect.
func disable():
	sprite.visible = false;
	set_deferred('monitoring', false);
	collectCoinParticles.emitting = true;

func _on_body_entered(body: Node2D):
	disable();
