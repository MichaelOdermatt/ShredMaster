extends Node2D

@onready var globals = get_node("/root/Globals");
@onready var cloudParticles = $CloudParticles

var particleEffectOffsetY: float = 5;

func _process(delta):
	updateParticleVelocity();

## Emits the cloud particle effect.
func emitCloudParticles(emitPosition: Vector2):
	cloudParticles.transform.origin = emitPosition;
	cloudParticles.transform.origin.y += particleEffectOffsetY;
	cloudParticles.emitting = true;
	pass

## Updates the velocity of all particle effects to match the global current base speed.
func updateParticleVelocity():
	cloudParticles.material.set('initial_velocity_min', -globals.currentBaseSpeed);
	cloudParticles.material.set('initial_velocity_max', -globals.currentBaseSpeed);

